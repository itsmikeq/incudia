class DashboardController < ApplicationController
  before_action :authenticate_user!

  def home
    @groups = current_user.groups
    @interests = current_user.interests
    @areas = current_user.areas
    puts "area count: #{@areas.count}"
    puts "Current user: #{current_user.inspect}"
    @companies = current_user.companies
    @content = current_user.embedded_contents

  end
end
