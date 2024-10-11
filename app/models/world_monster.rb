require "fuzzy_match"

class WorldMonster
  include Mongoid::Document
  include Mongoid::Timestamps

  store_in collection: "world_monsters"

  embeds_many :locations, class_name: "MonsterEmbed::Location", store_as: :locations
  embeds_many :weaknesses, class_name: "MonsterEmbed::Weakness", store_as: :weaknesses

  field :_id, type: String, default: -> { BSON::ObjectId.new.to_s }, overwrite: true
  field :name, type: String
  field :species, type: String
  field :description, type: String
  field :usefulInfo, type: String, as: :useful_info
  field :elements, type: Array
  field :ailments, type: Array
  field :resistances, type: Array
  field :threatLevel, type: Integer, as: :threat_level
  field :render, type: String
  field :icon, type: String

  validates_uniqueness_of :name

  index({ name: 1 })
  index({ species: 1 })
  index({ 'locations.name' => 1 })

  def is_tempered(locale)
    fz = FuzzyMatch.new(locations, :read => :name)
    location = fz.find(locale)
    return false unless location.present?

    !!location.tempered
  end
end