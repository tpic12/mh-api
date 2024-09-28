require 'json'

# Load JSON file
file_path = Rails.root.join('db', 'seeds', 'world_monsters.json')
monsters = JSON.parse(File.read(file_path))

# Seed data into the database
monsters.each do |monster_data|
  puts "Seeding: #{monster_data["name"]}"
  begin
    monster = WorldMonster.create!(
      name: monster_data["name"],
      species: monster_data["species"],
      description: monster_data["description"],
      useful_info: monster_data["useful_info"],
      elements: monster_data["elements"],
      ailments: monster_data["ailments"],
      resistances: monster_data["resistances"],
      threat_level: monster_data["threat_level"],
      render: monster_data["render"],
      icon: monster_data["icon"]
    )

    # Seed locations
    monster_data["locations"].each do |location_data|
      monster.locations.create!(
        name: location_data["name"],
        color: location_data["color"],
        icon: location_data["icon"]
      )
    end

    # Seed weaknesses
    monster_data["weaknesses"].each do |weakness_data|
      monster.weaknesses.create!(
        type: weakness_data["type"],
        rating: weakness_data["rating"],
        trait: weakness_data["trait"]
      )
    end
  rescue => e
    puts "Error seeding monster: #{monster_data['name']}: #{e.message}"
  end
end
