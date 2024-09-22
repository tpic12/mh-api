class Weakness
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :monster

  field :type, type: String
  field :rating, type: Integer
end
