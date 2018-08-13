class PropertySerializer < ActiveModel::Serializer
  attributes :house_number, :street, :city, :zip_code, :lat, :lng

  attribute :price do
    '%.2f' % @object.price.to_f
  end

  attribute :state do
    @object.city
  end
end
