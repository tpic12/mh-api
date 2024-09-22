class Monster
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :locations
  embeds_many :weaknesses

  field :name, type: String
  field :species, type: String
  field :description, type: String
  field :usefulInfo, type: String, as: useful_info
  field :elements, type: Array
  field :ailments, type: Array
  field :resistances, type: Array
  field :threatLevel, type: String, as: threat_level
end
