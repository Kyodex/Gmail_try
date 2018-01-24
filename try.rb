require 'nokogiri'
require 'open-uri'
require 'rest_client'
require "google_drive"
$array = []
$email = []

def get_all_the_urls_of_val_doise_townhalls (web_list)
page = Nokogiri::HTML(RestClient.get(web_list))#recupere le code html du site
#doc = Nokogiri::HTML(open(web_list)) = ligne 9
$is = 1
page.css("a.lientxt").each do |note|
note['href'] = note['href'][1..-1]#donne les urls de chaque commune en retirant le premier caractaire c-a-d "."
web_page = "http://annuaire-des-mairies.com" + note['href']
$array[$is] = note.text

get_the_email_of_a_townhal_from_its_webpage(web_page)#rappel la fonction get_the_email_of_a_townhal_from_its_webpage pour recuperer les adresses emails grace aux liens (fonctions recurssive)
end
end

def get_the_email_of_a_townhal_from_its_webpage (web_page)#recupère les emails d'une ville
doc = Nokogiri::HTML(RestClient.get(web_page))
#doc = Nokogiri::HTML(open(web_page)) = ligne 22
	doc.xpath('//p[@class = "Style22"]').each do |node|
    if node.text.include?("@")
			$email[$is] = node.text
      $is += 1
      node.text
	end
end
end

get_all_the_urls_of_val_doise_townhalls("http://annuaire-des-mairies.com/val-d-oise")

session = GoogleDrive::Session.from_config("config.json")
ws = session.spreadsheet_by_key("1YEwES38uA1BR3FQ0Z7JeMQa7dys6RQsPVWb4L2aYIKY").worksheets[0]
p ws[2, 1]

puts $email
puts $array

for j in (1..$array.length-1) do
   ws[j, 1] = $array[j]
    ws[j, 2] = $email[j]
    ws.save
  end






=begin
(1..ws.num_rows).each do |row|
  (1..ws.num_cols).each do |col|
    p ws[row, col]
  end
end

p ws.rows
ws.reload
=end
