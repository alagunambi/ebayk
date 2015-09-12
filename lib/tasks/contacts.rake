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
				email_field.value = "beharsllamniku@hotmail.de"
				password_field.value = "beharr"
		  end.submit

		  newpage = a.get('http://www.ebay-kleinanzeigen.de/s-dienstleistungen/seite:2/c297')
		  noko = newpage.search('body')

		  noko.css('.ad-title').each do |x|
		  	url = "http://www.ebay-kleinanzeigen.de/#{x['href']}"
		  	new_page = a.get(url)
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
              puts e.backtrace
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
	end

  task :clean => :environment do
    Ad.destroy_all
  end
end
