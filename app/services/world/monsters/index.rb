require "fuzzy_match"

module World
  module Monsters
    class Index < BaseService

      option :name, Types::String, optional: true
      option :species, Types::String, optional: true

      SPECIES = [
        "Bird Wyvern",
        "Brute Wyvern",
        "Fanged Beast",
        "Flying Wyvern",
        "Fanged Wyvern",
        "Elder Dragon",
        "Piscine Wyvern",
        "Relict"
      ].freeze

      def call
        if name.present?
          monsters = get_monster_by_name
        elsif species.present?
          monsters = get_monsters_by_species
        else
          monsters = WorldMonster.all
        end

        return monsters
      end

      private

      def get_monster_by_name
        match = WorldMonster.where(name: name.downcase)
        return match unless match.empty?
  
        fz = FuzzyMatch.new(WorldMonster.all, :read => :name)
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
        monsters = WorldMonster.where({species: {"$in": species_matches}})
        monsters.group_by { |mon| mon.species }
      end
    end
  end
end