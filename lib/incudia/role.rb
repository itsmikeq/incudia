module Incudia::Role
  class AccessError < StandardError;
  end
  LEVELS = {owner: 1, viewer: 2, participant: 3}

  def values
    LEVELS.values
  end

  def options
    LEVELS
  end

  def human_options
    _h = {}
    LEVELS.each do |l, lv|
      _h.merge!(l.to_s.humanize => lv)
    end
    _h
  end

  def access_val(val)
    LEVELS.select { |k, v| v == val }
  end

  def human_role
    access_val(self.send(access_field)).keys.first.to_s.humanize rescue "None"
  end

  def remove_role(_role)
    _new_role = current_role(_role)
    raise AccessError.new("Unable to find role #{_new_role}") unless _new_role
    self.send :update_attribute, access_field, current_access |= _new_role
  end

  def current_role(_new_role = nil)
    _new_role ||= access_val(self.send(access_field)).keys.first rescue nil
    if LEVELS.keys.include?(_new_role.to_sym)
      LEVELS[_new_role.to_sym]
    elsif LEVELS.values.include?(_new_role)
      _new_role
    end
  end

  def add_role(_new_role)
    _new_role = current_role(_new_role)
    raise AccessError.new("Unable to find role #{_new_role}") unless _new_role
    puts "New role will be: #{_new_role} on field #{access_field} currently it is #{self.send(access_field)}"
    current_access = self.send(self.send(:access_field))
    if current_access && current_access.to_i > 0
      self.send :update_attribute, access_field, current_access &= _new_role
    else
      self.send :update_attribute, access_field, _new_role
    end
  end

end