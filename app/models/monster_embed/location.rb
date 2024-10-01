module MonsterEmbed
  class Location
    include Mongoid::Document
  
    embedded_in :world_monster
  
    field :name, type: String
    field :color, type: String
    field :icon, type: String
    field :tempered, type: Boolean
  end
end
