class Location
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :monster

  field :name, type: String
  field :color, type: String
  field :icon, type: String
end
