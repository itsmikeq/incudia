module ApplicationHelper
  def title(value = nil)
    unless value.nil?
      @title = "#{value} | Incudia"      
    end
  end

  def extra_config
    Incudia.config.extra
  end

end
