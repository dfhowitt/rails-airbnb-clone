# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"

# User.create(
#   name: "Dan Howitt",
#   email: "dfhowitt@gmail.com",
#   password: 'blehbleh'
#   )
Booking.destroy_all
Property.destroy_all
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
pictures_array.each do |pic|

  file = URI.open(pic)


  property = Property.new(
    name: Faker::Address.community,
    property_type: types.sample,
    location: Faker::Address.city,
    description: Faker::Cannabis.health_benefit,
    price: price_range.sample,
    capacity: people_range.sample,
    availability: true,
    user: User.first
  )
  property.photos.attach(io: file, filename: 'property_pic.jpg', content_type: 'image/jpg')
  property.save

end

