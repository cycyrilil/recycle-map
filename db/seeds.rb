# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#
require "open-uri"
require "json"

p "------ DESTROY ALL --------"
User.destroy_all
PlaceCategory.destroy_all
Category.destroy_all
UserBadge.destroy_all
Badge.destroy_all
RecycleCategory.destroy_all
Recycle.destroy_all


p "creating some users"
cyril = User.create!(email: "cyril@mail.com", username: "Cyril", password: "zebizebi")
juan = User.create!(email: "juan@mail.com", username: "Juan", password: "juanjuan")
nono = User.create!(email: "nono@mail.com", username: "Noémie", password: "nononono")
p "#{User.count} users created"


p "creating some categories"
electronique = Category.create(name: "Électronique 🪫")
organique = Category.create(name: "Organique 🍌")
vetement = Category.create(name: "Vêtements 👚")
meuble = Category.create(name: "Meubles 🪑")
megot = Category.create(name: "Mégots 🚬")
autre = Category.create(name: "Autre 🗑️")
p "#{Category.count} categories created"

p "creating some badges"
badge_1 = Badge.create!(unlock_number: 2, name: "electroman", category: electronique, image: "pile_720.png" )
badge_2 = Badge.create!(unlock_number: 2, name: "organiqueman", category: organique, image: "banane_720.png")
badge_3 = Badge.create!(unlock_number: 2, name: "vêtementsman", category: vetement, image: "ve_tement_720.png")
badge_4 = Badge.create!(unlock_number: 2, name: "meublesman", category: meuble, image: "chaise_720.png")
badge_5 = Badge.create!(unlock_number: 2, name: "mégotsman", category: autre, image: "autre_720.png")
p "#{Badge.count} badges created"


  Place.destroy_all
  url_1 = "https://opendata.lillemetropole.fr/api/explore/v2.1/catalog/datasets/dechetterie/records?limit=20"

  uri = URI.open(url_1)
  data_1 = JSON.parse(uri.read)
  data_1["results"].each do |result|
    full_adresse = "#{result["adresse"]}, #{result["commune"]}"
    p "creating #{result["libelle"]}"
    Place.create!(name: result["libelle"], address: full_adresse, latitude: result["geometry"]["geometry"]["coordinates"][1], longitude: result["geometry"]["geometry"]["coordinates"][0], description: result["type"])
    PlaceCategory.create!(place: Place.last, category: electronique)
    PlaceCategory.create!(place: Place.last, category: organique)
    PlaceCategory.create!(place: Place.last, category: vetement)
    PlaceCategory.create!(place: Place.last, category: meuble)
    PlaceCategory.create!(place: Place.last, category: megot)
    PlaceCategory.create!(place: Place.last, category:  autre)
  end

  url_2 = "https://opendata.lillemetropole.fr/api/explore/v2.1/catalog/datasets/liste-zone-de-compostage-zero-dechet/records?limit=20"
  uri = URI.open(url_2)
  data_2 = JSON.parse(uri.read)
  data_2["results"].each do |result|
    full_adresse_3 = "#{result["adresse"]}, Roubaix"
    p "creating #{result["nom"]}"
    Place.create!(name: result["nom"], address: full_adresse_3, latitude: result["geo_shape"]["geometry"]["coordinates"][1], longitude: result["geo_shape"]["geometry"]["coordinates"][0])
    PlaceCategory.create!(place: Place.last, category: organique)
  end


  url_3 = "https://opendata.lillemetropole.fr/api/explore/v2.1/catalog/datasets/fichiers_biobox_lambersart/records?limit=9"
  uri = URI.open(url_3)
  data_3 = JSON.parse(uri.read)
  data_3["results"].each do |result|
    p "creating #{result["denomination"]}"
    Place.create!(name: result["denomination"], latitude: result["y"], longitude: result["x"])
    PlaceCategory.create!(place: Place.last, category: organique)
  end

  url_4 = "https://opendata.lillemetropole.fr/api/explore/v2.1/catalog/datasets/les-bennes-de-tri-selectif-a-roubaix/records?limit=27"
  uri = URI.open(url_4)
  data_4 = JSON.parse(uri.read)
  data_4["results"].each do |result|
    p "creating #{result["nombre_typ"]}"
    full_adresse_2 = "#{result["rues"]}, Roubaix"
    p "creating #{result["rues"]},"
    Place.create!(name: result["nombre_typ"], address: full_adresse_2, latitude: result["geo_shape"]["geometry"]["coordinates"][1], longitude: result["geo_shape"]["geometry"]["coordinates"][0])
    PlaceCategory.create!(place: Place.last, category: meuble)
    PlaceCategory.create!(place: Place.last, category: electronique)
  end


  15.times do
    place =  Place.order("RANDOM()").limit(1).first
    user = User.order("RANDOM()").limit(1).first
    recycle = Recycle.create(place: place, user: user)
    place.place_categories.each_with_index do |place_category, index|
      next if index.odd?
      recycle_category = RecycleCategory.create(recycle: recycle, category: place_category.category)
    end
  end

 p "-------CREATING BADGES FOR USER-------"

# Badge.all.each do |badge|

#   eligible_users = User.joins(recycles: { recycle_categories: :category })
#                       .where(categories: { id: badge.category.id })
#                       .group("users.id")
#                       .having("COUNT(DISTINCT recycle_categories.id) >= ?", badge.unlock_number)

#   eligible_users.each do |user|
#     UserBadge.create(user: user, badge: badge)
#   end
# end





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
