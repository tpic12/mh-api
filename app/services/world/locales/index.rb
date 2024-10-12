require "fuzzy_match"

module World
  module Locales
    class Index

      LOCALES = [
        "Forest Region",
        "Wildspire Region",
        "Rotted Region",
        "Coral Region",
        "Volcanic Region",
        "Tundra Region"
      ].freeze

      def initialize(params)
        @locale = params["locale"]
        @by_threat_level = params&.[]("filter")&.[]("by_threat_level")
        # @by_threat_level = params.dig("filter", "by_threat_level")
      end

      def call
        return unless monsters = build_query

        {
          monsterList: apply_filters(monsters),
          localeObject: reduce_locale_object(monsters)
        }
      end

      private

      def locale_match
        @locale_match ||= FuzzyMatch.new(LOCALES).find(@locale)
      end

      def build_query
        return if @locale.blank?
        monsters_by_locale
      end

      def apply_filters(monsters)
        return monsters unless @by_threat_level

        reduce_by_threat_level(monsters)
      end

      def monsters_by_locale
        WorldMonster.where("locations.name": locale_match)
      end

      def reduce_by_threat_level(monsters)
        monsters.each_with_object(Hash.new { |h, k| h[k] = [] }) do |monster, hash|
          monster_data = { name: monster.name, tempered: monster.is_tempered(@locale) }
          hash[monster.threat_level] << monster_data
        end
      end

      def reduce_locale_object(monsters)
        fuzzy_match = FuzzyMatch.new(monsters.first.locations, read: :name)
        matched_locale = fuzzy_match.find(@locale)

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
