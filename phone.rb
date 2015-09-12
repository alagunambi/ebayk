require 'mechanize'

a = Mechanize.new

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
	  number = noko2.css('#viewad-contact-phone').text

	  if ["015", "016 ", "017"].include?(number[0..2])
	    p number.to_s + " - interesting"
	  else
	  	p number.to_s + " - Not interesting"
	  end
  end
end
