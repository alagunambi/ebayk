class VisitorsController < ApplicationController
  def scrapping
    if params[:status] == "1"
      logger.info "inside 1"
      @pid = fork do
        exec "bundle exec rake contacts:from_ebayk"
      end
      logger.info @pid
      @status = @pid
    else
      logger.info "inside 2"
      if params[:pid]
        logger.info "inside pi"
        @status = Process.kill "TERM", pid
        logger.info @status
      end
    end
    respond_to do |format|
      if @status
        format.html { redirect_to :back, notice: 'Scheduled Ads gathering started now.' }
      else
        format.html { redirect_to :back, notice: 'Failed to scrap, please try again.' }
      end
    end
  end

  def destroy_all
    Ad.destroy_all
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Destroyed all contacts. I am ready for a fresh start.' }
    end
  end
end
