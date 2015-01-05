# == Schema Information
#
# Table name: interests
#
#  id               :integer          not null, primary key
#  name             :string
#  description      :string
#  type             :string
#  owner_id         :integer
#  owner_type       :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  visibility_level :integer
#
# Indexes
#
#  index_interests_on_name                     (name)
#  index_interests_on_owner_type_and_owner_id  (owner_type,owner_id)
#  index_interests_on_type                     (type)
#

require 'rails_helper'

RSpec.describe Interest, :type => :model do
  let!(:user) { create(:user) }
  context "associations" do
    it { should belong_to(:owner) }
  end
  context "errors" do
    it 'raises an error when missing a name' do
      expect { Interest.create!(name: nil, description: "Some stuff", owner: user) }.to raise_error()
    end

    it 'raises an error when missing a description' do
      expect { Interest.create!(name: "Some name", description: nil, owner: user) }.to raise_error()
    end

    it 'raises an error when missing a description' do
      expect { Interest.create!(name: "Some name", description: nil, owner: user) }.to raise_error()
    end

  end

  context "default value" do
    it 'visibility level' do
      expect(Interest.create!(name: "A name", description: "Some stuff", owner: user).visibility_level).to eq(Incudia::VisibilityLevel::PUBLIC)
    end

  end

end
