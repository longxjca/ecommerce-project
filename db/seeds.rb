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
# csv_file = Rails.root + "db/EtsyListingsDownload.csv"
# steam_csv = File.read(Rails.root.join("db/steam.csv"))
steam_csv = Rails.root + "db/steam.csv"
# options = { file_encoding: "iso-8859-1" } # Only needed if the CSV file was generated by Excel.
games = SmarterCSV.process(steam_csv, { col_sep: "\t" }) # Pass the 'options' hash as a second argument if CSV was created by Excel.
# games = CSV.parse(steam_csv, headers: true, encoding: "utf-8")
# description_csv = File.read(Rails.root.join("db/steam_description_data.csv"))
description_csv = Rails.root + "db/steam_description_data.csv"
descriptions = SmarterCSV.process(description_csv, { col_sep: "\t" })
# descriptions = CSV.parse(description_csv, headers: true, encoding: "utf-8")
# descriptions = SmarterCSV.process(description_csv, options)
# media_csv = File.read(Rails.root.join("db/steam_media_data.csv"))
# images = CSV.parse(media_csv, headers: true, encoding: "utf-8")
# puts games

# Publisher.create(name: "Not Exist")
# Developer.create(name: "Not Exist")
# puts games[0..2]
games[0..99].each do |game|
  game_description = ""
  descriptions.each do |description|
    if description[:steam_appid] == game[:appid]
      game_description = description[:short_description]
      break
    end
  end
  # puts game_description
  # puts "*********************************"
  # puts game
  # puts "|||||||||||||||||||||||||||||"
  # puts game[:name]
  # puts game.class
  # puts games.class
  # puts "_____________________________"

  # developer_entry = if game[:developer].present?
  #                     Developer.find_or_create_by(name: game[:developer])
  #                   else
  #                     Developer.find_by(name: "Not Exist")
  #                   end
  # publisher_entry = if game[:publisher].present?
  #                     Publisher.find_or_create_by(name: game[:publisher])
  #                   else
  #                     Publisher.find_by(name: "Not Exist")
  #                   end
  developer_entry = Developer.find_or_create_by(name: game[:developer])
  publisher_entry = Publisher.find_or_create_by(name: game[:publisher])
  # genre_entry = Genre.find_or_create_by(name: game[:genres])

  product_entry = Product.find_or_create_by(description:  game_description,
                                            name:         game[:name],
                                            price:        game[:price],
                                            developer:    developer_entry,
                                            publisher:    publisher_entry,
                                            release_date: game[:release_date])
  genres = game[:genres].split(";")
  genres.each do |genre_name|
    genre = Genre.find_or_create_by(name: genre_name)
    GenreProduct.create(genre: genre, product: product_entry)
  end

  # puts publisher_entry.inspect
end
puts "Created #{Product.count} products"
puts "Created #{Developer.count} developers"
puts "Created #{Publisher.count} developers"
puts "Created #{Genre.count} genres"
puts "Created #{GenreProduct.count} GenreProduct"
# puts "Created Joint tables rows"
