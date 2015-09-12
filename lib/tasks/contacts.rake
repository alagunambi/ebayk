require 'mechanize'

namespace :contacts do
  task :from_ebayk => :environment do

		a = Mechanize.new

		a.user_agent_alias = Ad.random_desktop_user_agent

		a.get('http://www.ebay-kleinanzeigen.de/') do |page|

			signin = a.click(page.link_with(:text => /Einloggen/))


			my_page = signin.form_with(:id => 'login-form') do |form|
				email_field = form.field_with(name: "loginMail")
				password_field = form.field_with(name: "password")

        account = Account.last
				email_field.value = account.username.to_s
				password_field.value = account.password.to_s
		  end.submit

      #		  newpage = a.get('http://www.ebay-kleinanzeigen.de/s-dienstleistungen/seite:2/c297')
      category_links = [
        "http://www.ebay-kleinanzeigen.de/s-dienstleistungen/seite:1/c297",
        "http://www.ebay-kleinanzeigen.de/s-auto-rad-boot/seite:1/c210",
        "http://www.ebay-kleinanzeigen.de/s-autoteile-reifen/seite:1/c223",
        "http://www.ebay-kleinanzeigen.de/s-motorraeder-roller/seite:1/c305",
        "http://www.ebay-kleinanzeigen.de/s-familie-kind-baby/seite:1/c17"
      ]

      category_links.each do |link|

        sleep(7.minutes)

  		  newpage = a.get(link)

  		  noko = newpage.search('body')

        get_ads(noko, a)

        loop do
          begin
            link = newpage.search("div.pagination").search("a.pagination-link").attr("href")
            page = a.get(link)
            noko = page.search('body')

            get_ads(noko, a)
          rescue => e
            puts e
            break
          end
        end
      end
		end
	end

  task :clean => :environment do
    Ad.destroy_all
  end
end

def get_ads(noko, agent)
  noko.css('.ad-title').each do |x|
    url = "http://www.ebay-kleinanzeigen.de/#{x['href']}"
    new_page = agent.get(url)
    noko2 = new_page.search('body')
    number = noko2.css('#viewad-contact-phone').text.squish.delete("^0-9")

    if ["015", "016 ", "017"].include?(number[0..2])
      if number.length == 11 || number.length == 12
        p number.to_s + " - interesting - " + url.to_s
        begin
          Ad.create!(:contact => number, :link => url, :ad_id => url.squish.delete("^0-9"))
        rescue => e
          puts "SSSSSTTTTTTTAAAAAAAAARRRRRRRRRRRTTTTTTTTTTTTTTTTTTTTTTTTT"
          puts e
          #puts e.backtrace
          puts "EEEEEEEEEEEEEEEENNNNNNNNNNNNNNNNNNNNDDDDDDDDDDDDDDDDDDDDD"
        end
      else
        p number.length
        p "Discarding for non-interesting length"
      end
    else
      p number.to_s + " - Not interesting"
    end
  end
end
