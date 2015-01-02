class InterestsService
  attr_accessor :user, :interest
  def initialize(user, interest)
    @user = user
    @interest = interest
  end

  def add

    user.interests << interest
  end

  def remove
    user.interests.where(interest: interest).destroy
  end

end