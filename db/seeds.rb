# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"

puts "destroying everything"

Review.destroy_all
Booking.destroy_all
Property.destroy_all
Service.destroy_all
User.destroy_all

puts "creating users"

user_names = %w(Jim Bob Bill Fred Greg George Sally Susan Mary Craig)

user_names.each do |name|
  User.create(name: name,
              email: "#{name}@gmail.com",
              password: "123456"
  )
end


puts "creating properties"

types = ['Island', 'Penthouse', 'Villa', 'Luxury Tent', 'Mansion', 'Estate']
price_range = (1000..10000).to_a
people_range = (1..30).to_a

pictures_array = ["https://res.cloudinary.com/daxoj4nny/image/upload/v1589902097/luxury%20properties/1-Exterior-Front-580x375_kdxmqc.jpg",
                  "https://res.cloudinary.com/daxoj4nny/image/upload/v1589902096/luxury%20properties/Why-you-dont-see-mega-rich-properties-on-the-market-1_u7uayq.jpg",
                  "https://res.cloudinary.com/daxoj4nny/image/upload/v1589902069/luxury%20properties/ralph-kayden-2d4lAQAlbDA-unsplash_aajlh3.jpg",
                  "https://res.cloudinary.com/daxoj4nny/image/upload/v1589901280/luxury%20properties/cliff-top-residence1-1100x733_l9nicr.jpg",
                  "https://res.cloudinary.com/daxoj4nny/image/upload/v1589901280/luxury%20properties/1.-Legend-Hill-Sothebys_ynvvxe.jpg",
                  "https://res.cloudinary.com/daxoj4nny/image/upload/v1589901280/luxury%20properties/ghtr_zzm8on.jpg",
                  "https://res.cloudinary.com/daxoj4nny/image/upload/v1589901280/luxury%20properties/PRI_86925433_wchgdj.jpg",
                  "https://res.cloudinary.com/daxoj4nny/image/upload/v1589901279/luxury%20properties/images_b89h97.jpg",
                  "https://res.cloudinary.com/daxoj4nny/image/upload/v1589901279/luxury%20properties/download_sqvayr.jpg",
                  "https://res.cloudinary.com/daxoj4nny/image/upload/v1589901279/luxury%20properties/images_1_womt3b.jpg"
                 ]




city_array = ['London', 'Madrid', 'Milan', 'Rome', 'Paris']
pictures_array.each do |pic|

  file = URI.open(pic)
  file2 = URI.open("https://res.cloudinary.com/cjw21889/image/upload/v1589819382/tyiztqupjkswwxmzqcwi.jpg")


  property = Property.new(
    name: Faker::Address.community,
    property_type: types.sample,
    location: city_array.sample,
    description: "#{Faker::Movie.quote} #{Faker::Movie.quote} #{Faker::Movie.quote}",
    price: price_range.sample,
    capacity: people_range.sample,
    availability: true,
    user: User.all.sample
  )
  property.photos.attach(io: file, filename: 'property_pic.jpg', content_type: 'image/jpg')
  property.photos.attach(io: file2, filename: 'property_pic2.jpg', content_type: 'image/jpg')
  property.save

end

fyrePic = "https://res.cloudinary.com/cjw21889/image/upload/v1589969665/vesf7y2yk23jzdglzrru.jpg"
fyrePic2 = "https://res.cloudinary.com/cjw21889/image/upload/v1590139405/fyre_2_ohgfzm.png"
fyre = URI.open(fyrePic)
fyre2 = URI.open(fyrePic2)
targetproperty = Property.new(
  name: 'Fyre Festival',
  property_type: types.sample,
  location: 'San Andreas',
  description: 'Live, Laugh, Love. Rent our fantasy Island, where all your dreams will come true and our celebrity chefs work round the clock to keep you fat and happy',
  price: 100000000,
  capacity: 800,
  availability: true,
  user: User.first
)

targetproperty.photos.attach(io: fyre, filename: 'property_pic1.jpg', content_type: 'image/jpg')
targetproperty.photos.attach(io: fyre2, filename: 'property_pic2.png', content_type: 'image/png')

targetproperty.save


puts "creating services"
services = %w(Butler Security Chef Lifeguard Maid Valet)
icons = ["fas fa-concierge-bell",
         "fas fa-shield-alt",
         "fas fa-utensils",
         "fas fa-swimmer",
         "fas fa-broom",
         "fas fa-car"
        ]
i = 0
services.each do |service|
  Service.create(name: service, icon: icons[i])
  i += 1
end


puts "creating reservations"

properties = Property.all

properties.each do |property|
  PropertyService.create(
    property: property,
    service: Service.all.sample
    )
  5.times do
    res_start_date = Faker::Date.forward(days: rand(1..15))
    Booking.create(
      property: property,
      user: User.all.sample,
      start_date: res_start_date,
      end_date: res_start_date + rand(1..10)
      )
  end
end

puts "creating reviews"

bookings = Booking.all

bookings.each do |booking|
  Review.create(
    content: Faker::Cannabis.health_benefit,
    rating: rand(1..5),
    booking: booking,
    user: User.all.sample
  )
end








