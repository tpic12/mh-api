require "fuzzy_match"

module Rise
  module Locales
    class Index < BaseService

      option :locale, Types::String
      option :by_threat_level, Types::Bool, optional: true, default: false
      option :by_species, Types::Bool, optional: true, default: false

      LOCALES = [
        "Shrine Ruins",
        "Sandy Plains",
        "Flooded Forest",
        "Lava Caverns",
        "The Citadel",
        "The Jungle",
        "Infernal Springs",
        "Frost Islands"
      ].freeze

      def call
        return if locale.blank?

        monsters = monsters_by_locale
        
        filtered_monsters = apply_filters(monsters)

        {
          monsterList: sort_list(filtered_monsters),
          localeObject: reduce_locale_object(monsters)
        }
      end

      private

      def apply_filters(monsters)
        if by_threat_level
          reduce_by_threat_level(monsters)
        elsif by_species
          reduce_by_species(monsters)
        else
          monsters
        end
      end

      def reduce_by_threat_level(monsters)
        monsters.group_by { |mon| mon.threat_level }
      end

      def reduce_by_species(monsters)
        monsters.group_by { |mon| mon.species }
      end

      def sort_list(list)
        list.sort_by { |key| key }.to_h
      end

      def locale_match
        @locale_match ||= FuzzyMatch.new(LOCALES).find(locale)
      end

      def monsters_by_locale
        RiseMonster.where("locations.name": locale_match)
      end

      def reduce_locale_object(monsters)
        fuzzy_match = FuzzyMatch.new(monsters.first.locations, read: :name)
        matched_locale = fuzzy_match.find(locale)

        monsters.each_with_object({}) do |monster, final_location|
          monster.locations.each do |location|
            next unless location["name"] == matched_locale&.name

            final_location["name"] ||= location["name"]
            final_location["color"] ||= location["color"]
            final_location["icon"] ||= location["icon"]
          end
        end
      end
    end
  end
end
