module MonsterEmbed
  class Location
    include Mongoid::Document
  
    embedded_in :monster
  
    field :name, type: String
    field :color, type: String
    field :icon, type: String
  end
end