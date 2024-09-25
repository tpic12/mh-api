module MonsterEmbed
  class Weakness
    include Mongoid::Document
  
    embedded_in :world_monster
  
    field :type, type: String
    field :rating, type: Integer
    field :trait, type: String
  end
end
