require 'gmail'
require 'mail'
require 'gmail_xoauth'
require "google_drive"
session = GoogleDrive::Session.from_config("config.json")#fichier a importer soit meme
ws = session.spreadsheet_by_key("1YEwES38uA1BR3FQ0Z7JeMQa7dys6RQsPVWb4L2aYIKY").worksheets[0]
gmail = Gmail.connect(".........", "......")

for i in (1..204)do
s = ws[i,4]
puts s

email = gmail.compose do
  to s
  subject "Deuxieme essaie!"
  body "Spent this email for fun, read this ....
  Bonjour,
Je m'appelle Personne, je suis élève à une formation de code gratuite, ouverte à tous, sans restriction géographique, ni restriction de niveau. La formation s'appelle The Hacking Project (http://thehackingproject.org/). Nous apprenons l'informatique via la méthode du peer-learning : nous faisons des projets concrets qui nous sont assignés tous les jours, sur lesquel nous planchons en petites équipes autonomes. Le projet du jour est d'envoyer des emails à nos élus locaux pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation gratuite.

Nous vous contactons pour vous parler du projet, et vous dire que vous pouvez ouvrir une cellule à {townhall_name}, où vous pouvez former gratuitement 6 personnes (ou plus), qu'elles soient débutantes, ou confirmées. Le modèle d'éducation de The Hacking Project n'a pas de limite en terme de nombre de moussaillons (c'est comme cela que l'on appelle les élèves), donc nous serions ravis de travailler avec Personne !
Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80"

end
gmail.deliver(email)
  sleep(5)
end
gmail.logout
