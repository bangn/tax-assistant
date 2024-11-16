# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
return unless Rails.env.development?

user = User.first

10.times do |index|
  receipt = Receipt.new(
    user_id: user.id,
    seller: Faker::Company.name,
    description: Faker::Lorem.sentence,
    total_amount: Faker::Number.decimal(l_digits: 2),
    date: Faker::Date.backward(days: index)
  )
  receipt.image.attach(io: File.open(Rails.root.join("db/images/seed-receipt.png")), filename: "receipt.png")
  receipt.save!
end
