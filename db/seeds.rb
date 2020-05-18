# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  name: "Dan Howitt",
  email: "dfhowitt@gmail.com",
  password: 'blehbleh'
  )

types = ['Island', 'Penthouse', 'Villa', 'Luxury Tent', 'Mansion', 'Estate']
price_range = (1000..10000).to_a
people_range = (1..30).to_a

10.times do
  Property.create(
    name: Faker::Address.community,
    property_type: types.sample,
    location: Faker::Address.city,
    description: Faker::Cannabis.health_benefit,
    price: price_range.sample,
    capacity: people_range.sample,
    availability: true,
    user: User.first
  )
end
