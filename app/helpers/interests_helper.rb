module InterestsHelper
  def interest_head_title
    if @interest
      @interest.try :name
    else
      "Interests"
    end
  end
end
