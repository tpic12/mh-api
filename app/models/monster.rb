class Monster
  include Mongoid::Document
  include Mongoid::Timestamps

  store_in collection: "monsters"

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
  field :threatLevel, type: String, as: :threat_level

  validates_presence_of :name
end

# {
#     "name": "Fatalis",
#     "species": "Elder Dragon",
#     "description": "A legendary black dragon known only as Fatalis. Rumored to have destroyed a kingdom in a single night, and has taken its castle for a roost.",
#     "useful_info": "As Long as its horns are intact, overcoming its final form's breath attack may be impossible. Cannons and ballistae can topple it. Flinch shots when its flying or standing will lower its head.",
#     "elements": ["Fire"],
#     "ailments": ["Fireblight"],
#     "resistances": ["Stun"],
#     "threat-level": "none",
#     "weakness": [
#       "Dragon (⭐⭐⭐)",
#       "Ice (⭐)",
#       "Water (⭐)",
#       "Thunder (⭐)",
#       "Fire (⭐⭐)",
#       "Poison (⭐)",
#       "Sleep (⭐)",
#       "Paralysis (⭐)",
#       "Blast (⭐)"
#     ],
#     "locations": [
#       {
#         "name": "Castle Schrade",
#         "color": "0x750099",
#         "icon": "mapIcon.png"
#       }
#     ]
#   }
