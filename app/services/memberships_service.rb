# TODO: Use this class to interact with Areas, Groups, Interests, etc.
class MembershipsService
  attr_accessor :member, :of, :level
  def initialize(member, of, level)
    @member = member
    @of = of
    @level = level
  end

  def execute
    # TODO: Put in some intelligence here to account for duplicates, etc.
    Membership.create(member: member, of: of, level: level)
  end

end