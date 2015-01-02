module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Incudia"      
    end
  end
end
