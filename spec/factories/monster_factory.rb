FactoryBot.define do
  factory :world_monster do
    name { "rathalos" }
    species { "flying wyvern" }
    description { Faker::Lorem.sentence }
    useful_info { Faker::Lorem.sentence }
    elements { %w[fire blast] }
    ailments { %w[blast] }
    resistances { %w[thunder blast] }
    threat_level { 1 }

    locations do
      [
        {
          name: Faker::Lorem.word,
          color: Faker::Color.hex_color,
          icon: Faker::Internet.url
        }
      ]
    end

    weaknesses do
      [
        {
          type: "water",
          rating: 3,
          trait: "charged"
        },
        {
          type: "dragon",
          rating: 2,
        }
      ]
    end
  end
end
