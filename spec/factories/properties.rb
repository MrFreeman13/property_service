FactoryBot.define do
  factory :property do
    offer_type 'sell'
    property_type 'apartment'
    zip_code '10405'
    city 'Berlin'
    street 'Marienburger Straße'
    house_number '31'
    lng 52.534993
    lat 13.4211476
    construction_year 1876
    number_of_rooms 2.0
    currency 'eur'
    price 350000
  end
end
