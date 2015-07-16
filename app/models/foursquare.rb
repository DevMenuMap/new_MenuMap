class Foursquare

  include ActiveModel::Validations
  # include ActiveModel::Conversion
  # extend ActiveModel::Naming

  attr_accessor :username
  attr_accessor :url

  validates :username, :presence => true
  validates :url,  :presence => true

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
end
