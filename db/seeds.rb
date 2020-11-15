# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"
GenreProduct.destroy_all
ProductOrder.destroy_all
Product.destroy_all
Order.destroy_all
Account.destroy_all
Province.destroy_all
Genre.destroy_all
Developer.destroy_all
Publisher.destroy_all
Page.destroy_all
AdminUser.destroy_all
if Rails.env.development?
  AdminUser.create!(email: "admin@example.com", password: "password", password_confirmation: "password")
end
steam_csv = File.read(Rails.root.join("db/steam.csv"))
options = { file_encoding: "iso-8859-1" } # Only needed if the CSV file was generated by Excel.
games = SmarterCSV.process(steam_csv, options) # Pass the 'options' hash as a second argument if CSV was created by Excel.
# games = CSV.parse(steam_csv, headers: true, encoding: "utf-8")
# description_csv = File.read(Rails.root.join("db/steam_description_data.csv"))
# descriptions = CSV.parse(description_csv, headers: true, encoding: "utf-8")
# descriptions = SmarterCSV.process(description_csv, options)
# media_csv = File.read(Rails.root.join("db/steam_media_data.csv"))
# images = CSV.parse(media_csv, headers: true, encoding: "utf-8")

games.each do |game|
  # game_description = ""
  # descriptions.each do |description|
  #   if description["steam_appid"] == game["appid"]
  #     game_description = description["detailed_description"]
  #     break
  #   end
  # end

  developer_entry = Developer.find_or_create_by(name: game["developer"])
  publisher_entry = Publisher.find_or_create_by(name: game["publisher"])

  Product.find_or_create_by(
    name:         game["name"],
    price:        game["price"],
    developer:    developer_entry,
    publisher:    publisher_entry,
    release_date: game["release_date"]
  )
end
# puts 'Created #{Product.count} products'
# puts "Created Joint tables rows"
