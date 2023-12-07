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
demo = User.create!(email: "demo@mail.com", username: "Demo", password: "zebizebi")
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
badge_1 = Badge.create!(unlock_number: 2, name: "Électronique", category: electronique, image: "pile_720.png" )
badge_2 = Badge.create!(unlock_number: 2, name: "Organique", category: organique, image: "banane_720.png")
badge_3 = Badge.create!(unlock_number: 2, name: "Vêtements", category: vetement, image: "ve_tement_720.png")
badge_4 = Badge.create!(unlock_number: 2, name: "Meubles", category: meuble, image: "chaise_720.png")
badge_5 = Badge.create!(unlock_number: 2, name: "Mégots", category: megot, image: "clope.png")
p "#{Badge.count} badges created"


  Place.destroy_all

  url_1 = "https://opendata.lillemetropole.fr/api/explore/v2.1/catalog/datasets/dechetterie/records?limit=20"

  uri = URI.open(url_1)
  data_1 = JSON.parse(uri.read)
  data_1["results"].each do |result|
    full_adresse = "#{result["adresse"]}, #{result["commune"]}"
    p "creating #{result["libelle"]}"
    Place.create!(name: result["libelle"], address: full_adresse, latitude: result["geometry"]["geometry"]["coordinates"][1], longitude: result["geometry"]["geometry"]["coordinates"][0], description: result["type"])
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
  end
  url_5 = "https://www.cercle-recyclage.asso.fr/"
  Place.create!(name: "Cercle Recyclage", address: "5 Rue Jules de Vicq, 59800 Lille" , latitude: 50.3756, longitude: 3.0511)
  PlaceCategory.create!(place: Place.last, category: organique)


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



p "creating some places"
place_1 = Place.create!(name: "Recuperation et recyclage pour le dÉveloppement", description: "mobiliser l'ensemble des acteurs sur des projets et programmes nationaux et ou internationaux de récupération et de recyclage des équipements dans les différents secteurs économiques ; ces équipements sont destinés à une réutilisation en France et dans les pays africains dans une démarche de solidarité et de développement durable", address: "25 bis Rue Eugene Varlin 59000 Lille", latitude: 50.64794, longitude: 3.0037308, contact: "06 51 51 51 51. Minimum de dépôt : 10kg de déchets.")
PlaceCategory.create!(place: Place.last, category: meuble)



place_2 = Place.create!(name: "les plasticoeurs", description: "oeuvrer, expliquer aux partenaires en Europe et plus précisément en France l'importance de participer sur le thème de l'écologie avec les associations du même ordre en place en Afrique, travailler sur les techniques de collectes,de tri des déchets,de fabrication artisanale d'objets recyclés voire de transformation en pâte et/ou d'hydrocarbures ( technique de pyrolyse);", address: "Avenue de la Republique 59000 Lille", latitude: 50.6304071, longitude: 3.0139712, contact: "06 51 51 51 51. Minimum de dépôt : 10kg de déchets.")
PlaceCategory.create!(place: Place.last, category: meuble)
PlaceCategory.create!(place: Place.last, category: autre)

place_3 = Place.create!(name:"Sustain clothes", description: "L'association Doggy Poop est spécialiste du recyclage de selles canines depuis 1976. Après avoir extrait la matière organique, nous récupérons les nutriments restants grâce à la chimie quantique, et les transformons en compléments alimentaires.", address: "38 Rue Ampere 59130 Lambersart", latitude: 50.6413352, longitude: 3.0208549, contact: "06 51 51 51 51. Minimum de dépôt : 10kg de déchets.")
PlaceCategory.create!(place: Place.last, category: vetement)

place_4 = Place.create!(name:"communauté Emmaüs Wambrechies", description: "L'association Doggy Poop est spécialiste du recyclage de selles canines depuis 1976. Après avoir extrait la matière organique, nous récupérons les nutriments restants grâce à la chimie quantique, et les transformons en compléments alimentaires.", address: "1 Chem. du Fort, 59118 Wambrechies", latitude: 50.6828, longitude: 3.0478,)
PlaceCategory.create!(place: Place.last, category: vetement)
PlaceCategory.create!(place: Place.last, category: meuble)
PlaceCategory.create!(place: Place.last, category: electronique)
p "#{Place.count} places created"

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
