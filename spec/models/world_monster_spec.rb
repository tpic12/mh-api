require 'rails_helper'

RSpec.describe WorldMonster, type: :model do
  describe '#validations' do

    let(:monster) {create(:world_monster)}

    it 'tests that factory is valid' do
      expect(monster).to be_valid
    end

    it 'has an invalid name' do
      monster.name = ''
      expect(monster).not_to be_valid
      expect(monster.errors[:name]).to include("can't be blank")
    end
  end
end
