require 'rails_helper'

RSpec.describe Area, :type => :model do
  let!(:user) { create(:user) }
  context 'associations' do
    it { should belong_to(:owner) }
    it { should have_many(:focalpoints) }
  end
  context "errors" do
    it 'raises an error when missing a name' do
      expect { Area.create!(name: nil, description: "Some stuff", owner: user) }.to raise_error()
    end

    it 'raises an error when missing a description' do
      expect { Area.create!(name: "Some name", description: nil, owner: user) }.to raise_error()
    end

    it 'raises an error when missing a description' do
      expect { Area.create!(name: "Some name", description: nil, owner: user) }.to raise_error()
    end

  end

  context "default value" do
    it 'visibility level' do
      expect(Area.create!(name: "A name", description: "Some stuff", owner: user).visibility_level).to eq(Incudia::VisibilityLevel::PUBLIC)
    end

  end

end
