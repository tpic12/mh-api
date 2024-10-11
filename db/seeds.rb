require 'json'

# Load JSON file
world_file_path = Rails.root.join('db', 'seeds', 'world_monsters.json')
rise_file_path = Rails.root.join('db', 'seeds', 'rise_monsters.json')
world_monsters = JSON.parse(File.read(world_file_path))
rise_monsters = JSON.parse(File.read(rise_file_path))

# Seed world data into the database
world_monsters.each do |monster_data|
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
        icon: location_data["icon"],
        tempered: location_data["tempered"]
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

  # Seed rise data into the database
rise_monsters.each do |monster_data|
  puts "Seeding: #{monster_data["name"]}"
  begin
    monster = RiseMonster.create!(
      name: monster_data["name"],
      species: monster_data["species"],
      description: monster_data["description"],
      useful_info: monster_data["useful_info"],
      elements: monster_data["elements"],
      ailments: monster_data["ailments"],
      resistances: monster_data["resistances"],
      threat_level: monster_data["threat_level"],
      rampage_role: monster_data["rampage_role"],
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
