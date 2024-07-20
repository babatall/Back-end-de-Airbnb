require 'faker'

# Détruire les données existantes
User.destroy_all
City.destroy_all
Listing.destroy_all
Reservation.destroy_all

# Méthode pour générer des numéros de téléphone français valides
def generate_french_phone_number
  prefixes = ['06', '07']
  prefix = prefixes.sample
  number = 8.times.map { rand(10) }.join
  "#{prefix}#{number}"
end

# Méthode pour générer des codes postaux français valides
def generate_french_zip_code
  departments = (1..95).to_a - [20] + ['2A', '2B'] # inclure la Corse
  department = departments.sample
  if department == '2A' || department == '2B'
    "#{department}#{rand(0..9)}#{rand(0..9)}"
  else
    "#{format('%02d', department)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}"
  end
end

# Créer des utilisateurs
20.times do
  User.create!(
    email: Faker::Internet.unique.email,
    phone_number: generate_french_phone_number,
    description: Faker::Lorem.paragraph
  )
end

# Créer des villes
10.times do
  City.create!(
    name: Faker::Address.city,
    zip_code: generate_french_zip_code
  )
rescue ActiveRecord::RecordInvalid
end

# Créer des listings
50.times do
  Listing.create!(
    available_beds: rand(1..5),
    price: rand(50..200),
    description: Faker::Lorem.characters(number: 140),
    has_wifi: [true, false].sample,
    welcome_message: Faker::Lorem.sentence,
    user: User.all.sample,
    city: City.all.sample
  )
end

# Créer des réservations
Listing.all.each do |listing|
  5.times do
    begin
      Reservation.create!(
        start_date: Faker::Date.backward(days: 30),
        end_date: Faker::Date.backward(days: 20),
        user: User.all.sample,
        listing: listing
      )
    rescue ActiveRecord::RecordInvalid
      # Ignorer les erreurs de validation pour les réservations qui se chevauchent
    end
  end

  5.times do
    begin
      Reservation.create!(
        start_date: Faker::Date.forward(days: 20),
        end_date: Faker::Date.forward(days: 30),
        user: User.all.sample,
        listing: listing
      )
    rescue ActiveRecord::RecordInvalid
      # Ignorer les erreurs de validation pour les réservations qui se chevauchent
    end
  end
end

puts "Seed terminé avec succès"
