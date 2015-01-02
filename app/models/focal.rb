class Focal < ActiveRecord::Base
  belongs_to :area, polymorphic: true
  belongs_to :owner, polymorphic: true
end
