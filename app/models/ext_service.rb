class ExtService < ActiveRecord::Base
  belongs_to :ext_service
  belongs_to :consumer, polymorphic: true
end
