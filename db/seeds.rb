# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#

User.destroy_all
p "creating some users"
cyril = User.create!(email: "cyril@mail.com", username: "cycyrilil", password: "zebizebi")
juan = User.create!(email: "juan@mail.com", username: "juan", password: "juanjuan")
nono = User.create!(email: "nono@mail.com", username: "nono", password: "nononono")
p "#{User.count} users created"

Category.destroy_all
p "creating some categories"
category_1 = Category.create!(name: "Électronique")
category_2 = Category.create!(name: "Organique")
category_3 = Category.create!(name: "Vêtements")
category_4 = Category.create!(name: "Meubles")
category_5 = Category.create!(name: "Mégots")
p "#{Category.count} categories created"

Badge.destroy_all
p "creating some badges"
badge_1 = Badge.create!(unlock_number: 2, name: "electroman", category: category_1)
badge_2 = Badge.create!(unlock_number: 2, name: "organiqueman", category: category_2)
badge_3 = Badge.create!(unlock_number: 2, name: "vêtementsman", category: category_3)
badge_4 = Badge.create!(unlock_number: 2, name: "meublesman", category: category_4)
badge_5 = Badge.create!(unlock_number: 2, name: "mégotsman", category: category_5)
p "#{Badge.count} badges created"

  require "open-uri"
  require "json"

  Place.destroy_all

  url_1 = "https://opendata.lillemetropole.fr/api/explore/v2.1/catalog/datasets/dechetterie/records?limit=20"

  uri = URI.open(url_1)
  data_1 = JSON.parse(uri.read)
  data_1["results"].each do |result|
    full_adresse = "#{result["adresse"]}#{result["commune"]}"
    p "creating #{result["libelle"]}"
    Place.create!(name: result["libelle"], address: full_adresse, latitude: result["geometry"]["geometry"]["coordinates"][1], longitude: result["geometry"]["geometry"]["coordinates"][0], description: result["type"])
  end

  url_2 = "https://opendata.lillemetropole.fr/api/explore/v2.1/catalog/datasets/liste-zone-de-compostage-zero-dechet/records?limit=20"
  uri = URI.open(url_2)
  data_2 = JSON.parse(uri.read)
  data_2["results"].each do |result|
    p "creating #{result["nom"]}"
    Place.create!(name: result["nom"], latitude: result["geo_shape"]["geometry"]["coordinates"][1], longitude: result["geo_shape"]["geometry"]["coordinates"][0])
  end


  url_3 = "https://opendata.lillemetropole.fr/api/explore/v2.1/catalog/datasets/fichiers_biobox_lambersart/records?limit=9"
  uri = URI.open(url_3)
  data_3 = JSON.parse(uri.read)
  data_3["results"].each do |result|
    p "creating #{result["denomination"]}"
    Place.create!(name: result["denomination"], latitude: result["y"], longitude: result["x"])
  end

  url_4 = "https://opendata.lillemetropole.fr/api/explore/v2.1/catalog/datasets/les-bennes-de-tri-selectif-a-roubaix/records?limit=27"
  uri = URI.open(url_4)
  data_4 = JSON.parse(uri.read)
  data_4["results"].each do |result|
    p "creating #{result["nombre_typ"]}"
    p "creating #{result["rues"]}"
    Place.create!(name: result["nombre_typ"], latitude: result["geo_shape"]["geometry"]["coordinates"][1], longitude: result["geo_shape"]["geometry"]["coordinates"][0])
  end
# p "creating some places"
# place_1 = Place.create!(name: "Compos't de Pomme", description: "Charles et Alice vous invitent à recycler vos déchets organiques dans leur composteur douillet au coeur de Lille. Après un traitement révolutionnaire, vos épluchures et autres coquilles d'oeufs seront transformées en goûter fruités, distribués aux enfants dans toutes les cantines de la métropôle. C'est la définition même d'un circuit court, qui profite à tous !", address: "14, Boulevard de la Liberté, 59000 Lille", contact: "L'association est ouverte tous les jours de 9h à 18h et joignable au 0645637893.")
# place_2 = Place.create!(name: "Cy-clopes", description: "Vous ne savez pas quoi faire de vos vieux mégots de cigarette ? Apportez-les à l'association Cy-clopes : nous les transformeront en plaids tous doux.", address: "18, Boulevard de la Liberté, 59000 Lille", contact: "0645637893. Minimum de dépôt : 40kg de mégots.")
# place_3 = Place.create!(name: "Doggy Poop", description: "L'association Doggy Poop est spécialiste du recyclage de selles canines depuis 1976. Après avoir extrait la matière organique, nous récupérons les nutriments restants grâce à la chimie quantique, et les transformons en compléments alimentaires.", address: "14, parc Jean-Baptiste Lebas, 59000 Lille", contact: "Ce qui ne nous tue pas l'odorat nous rend plus forts.")
# p "#{Place.count} places created"

# Recycle.destroy_all
# p "creating some recycle"
# recycle_1 = Recycle.create!(place: place_1, user: nono)
# recycle_2 = Recycle.create!(place: place_2, user: nono)
# p "#{Recycle.count} recycles created"

# RecycleCategory.destroy_all
# p "creating some recycle categories"
# recycle_category_1 = RecycleCategory.create!(category: category_1, recycle: recycle_1)
# recycle_category_2 = RecycleCategory.create!(category: category_2, recycle: recycle_2)
# p "#{RecycleCategory.count} recycle categories created"

# UserBadge.destroy_all
# p "creating some user badges"
# user_badge_1 = UserBadge.create!(badge: badge_1, user: nono)
# user_badge_2 = UserBadge.create!(badge: badge_2, user: nono)
# p "#{UserBadge.count} user badges created"
