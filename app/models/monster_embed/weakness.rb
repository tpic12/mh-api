module MonsterEmbed
  class Weakness
    include Mongoid::Document
  
    embedded_in :monster
  
    field :type, type: String
    field :rating, type: Integer
  end
end
