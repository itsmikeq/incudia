module ApplicationHelper
  def title(value = nil)
    unless value.nil?
      @title = "#{value} | Incudia"      
    end
  end

  def extra_config
    Incudia.config.extra
  end

  def hexdigest(string)
    Digest::SHA1.hexdigest string
  end

  def authbutton(provider, size = 64)
    image_tag('', alt: "Sign in with #{provider.to_s.titleize}", class: "btn btn-block btn-social btn-#{provider.to_s}")
  end

  def time_ago_with_tooltip(date, placement = 'top', html_class = 'time_ago')
    capture_haml do
      haml_tag :time, date.to_s,
               class: html_class, datetime: date.getutc.iso8601, title: date.stamp("Aug 21, 2011 9:23pm"),
               data: { toggle: 'tooltip', placement: placement }

      haml_tag :script, "$('." + html_class + "').timeago().tooltip()"
    end.html_safe
  end


  def broadcast_message
    BroadcastMessage.current
  end

  def simple_sanitize(str)
    sanitize(str, tags: %w(a span))
  end

  # Check if a particular controller is the current one
  #
  # args - One or more controller names to check
  #
  # Examples
  #
  #   # On TreeController
  #   current_controller?(:tree)           # => true
  #   current_controller?(:commits)        # => false
  #   current_controller?(:commits, :tree) # => true
  def current_controller?(*args)
    args.any? { |v| v.to_s.downcase == controller.controller_name }
  end

  # Check if a particular action is the current one
  #
  # args - One or more action names to check
  #
  # Examples
  #
  #   # On Projects#new
  #   current_action?(:new)           # => true
  #   current_action?(:create)        # => false
  #   current_action?(:new, :create)  # => true
  def current_action?(*args)
    args.any? { |v| v.to_s.downcase == action_name }
  end

  def body_data_page
    path = controller.controller_path.split('/')
    namespace = path.first if path.second

    [namespace, controller.controller_name, controller.action_name].compact.join(":")
  end

end
