# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "csv"

path = Rails.root.join("db", "data", "SSBU_FIGHTERS.csv")
raise "CSV not found at #{path}" unless File.exist?(path)

Fighter.delete_all

CSV.foreach(path, headers: true) do |row|
  Fighter.create!(
    character: row["character"],
    introduced_in: row["introduced_in"],
    game_series: row["game_series"],
    has_spike: row["has_spike"] == "TRUE",
    has_projectiles: row["has_projectiles"] == "TRUE",
    has_counter: row["has_counter"] == "TRUE",
    has_reflector: row["has_reflector"] == "TRUE"
  )
end

puts "Seeded #{Fighter.count} fighters"
