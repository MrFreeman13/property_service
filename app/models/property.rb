class Property < ApplicationRecord
  def self.similar(lng:, lat:, property_type:, marketing_type:, distance: 5000)
    query = <<-SQL
      SELECT properties.house_number, properties.street, properties.city, properties.zip_code, properties.lat, properties.lng, properties.price
      FROM properties
      WHERE property_type = :property_type AND offer_type = :marketing_type
      AND earth_box(ll_to_earth(:latitude, :longitude), :distance) @> ll_to_earth(properties.lat, properties.lng)
    SQL

    self.find_by_sql([query, { property_type: property_type,
                               marketing_type: marketing_type,
                               latitude: lat.to_f,
                               longitude: lng.to_f,
                               distance: distance
    }])
  end
end
