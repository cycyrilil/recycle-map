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

  url = "https://opendata.lillemetropole.fr/api/explore/v2.1/catalog/datasets/dechetterie/records?limit=20"

  uri = URI.open(url)
  data = JSON.parse(uri.read)
  data["results"].each do |result|
    p "creating #{result["libelle"]}"
    Place.create!(name: result["libelle"], address: result["adresse"], latitude: result["geometry"]["geometry"]["coordinates"][1], longitude: result["geometry"]["geometry"]["coordinates"][0], description: result["type"])
  end

Recycle.destroy_all
p "creating some recycle"
recycle_1 = Recycle.create!(place: place_1, user: nono)
recycle_2 = Recycle.create!(place: place_2, user: nono)
p "#{Recycle.count} recycles created"

RecycleCategory.destroy_all
p "creating some recycle categories"
recycle_category_1 = RecycleCategory.create!(category: category_1, recycle: recycle_1)
recycle_category_2 = RecycleCategory.create!(category: category_2, recycle: recycle_2)
p "#{RecycleCategory.count} recycle categories created"

UserBadge.destroy_all
p "creating some user badges"
user_badge_1 = UserBadge.create!(badge: badge_1, user: nono)
user_badge_2 = UserBadge.create!(badge: badge_2, user: nono)
p "#{UserBadge.count} user badges created"
