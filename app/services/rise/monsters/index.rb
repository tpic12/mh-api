require "fuzzy_match"

module Rise
  module Monsters
    class Index < BaseService

      option :name, Types::String, optional: true
      option :species, Types::String, optional: true

      SPECIES = [
        "Bird Wyvern",
        "Leviathan",
        "Brute Wyvern",
        "Fanged Beast",
        "Flying Wyvern",
        "Fanged Wyvern",
        "Elder Dragon",
        "Carapaceon",
        "Piscine Wyvern",
        "Temnoceran"
      ].freeze

      def call
        if name.present?
          monsters = get_monster_by_name
        elsif species.present?
          monsters = get_monsters_by_species
        else
          monsters = RiseMonster.all
        end

        return monsters
      end

      private

      def get_monster_by_name
        match = RiseMonster.where(name: name.downcase)
        return match unless match.empty?
  
        fz = FuzzyMatch.new(RiseMonster.all, :read => :name)
        [fz.find(name)]
      end

      def species_matches
        exact_matches = SPECIES.select { |sp| sp.downcase.include?(species.downcase) }

        if exact_matches.empty?
          fuzzy_matches = FuzzyMatch.new(SPECIES).find_all(species)

          fuzzy_matches.select { |sp| sp.downcase.include?(species.downcase) }
        else
          exact_matches
        end
      end

      def get_monsters_by_species
        monsters = RiseMonster.where({species: {"$in": species_matches}})
        monsters.group_by { |mon| mon.species }
      end
    end
  end
end