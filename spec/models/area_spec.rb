# == Schema Information
#
# Table name: areas
#
#  id               :integer          not null, primary key
#  name             :string
#  description      :string
#  owner_id         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  visibility_level :integer
#  owner_type       :string
#
# Indexes
#
#  index_areas_on_owner_id          (owner_id)
#  index_areas_on_visibility_level  (visibility_level)
#

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

  context "with users" do
    let(:area){ create(:area) }
    it 'allows for adding users' do
      user.areas << area
      expect(user.areas).to include(area)
    end
  end

  context "with focal point" do
    let(:area){ create(:area) }
    let(:fc){ create(:focalpoint) }
    it 'allows for adding users' do
      area.focalpoints << fc
      expect(area.focalpoints).to include(fc)
    end
  end

end
