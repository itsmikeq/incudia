class Settings < Settingslogic
  source ENV.fetch('INCUDIA_CONFIG') { "#{Rails.root}/config/incudia.yml" }
  namespace Rails.env

  class << self
    def incudia_on_standard_port?
      incudia.port.to_i == (incudia.https ? 443 : 80)
    end

    private
    def build_incudia_url
      custom_port = incudia_on_standard_port? ? nil : ":#{incudia.port}"
      [incudia.protocol,
       "://",
       incudia.host,
       custom_port,
       incudia.relative_url_root
      ].join('')
    end

    # check that values in `current` (string or integer) is a constant in `module`.
    def verify_constant_array(modul, current, default)
      values = default || []
      if !current.nil?
        values = []
        current.each do |constant|
          values.push(verify_constant(modul, constant, nil))
        end
        values.delete_if { |value| value.nil? }
      end
      values
    end

    # check that `current` (string or integer) is a constant in `module`.
    def verify_constant(modul, current, default)
      constant = modul.constants.find { |name| modul.const_get(name) == current }
      value    = constant.nil? ? default : modul.const_get(constant)
      if current.is_a? String
        value = modul.const_get(current.upcase) rescue default
      end
      value
    end

  end
end

Settings['incudia']                                            ||= Settingslogic.new({})
Settings.incudia['default_can_create_group']                   = true if Settings.incudia['default_can_create_group'].nil?
Settings.incudia['host']                                       ||= 'localhost'
Settings.incudia['https']                                      = false if Settings.incudia['https'].nil?
# Broken :(
# Settings.incudia['url']                                        ||= Settings.send(:build_incudia_url)
Settings.incudia['protocol']                                   ||= Settings.incudia.https ? "https" : "http"
# Broken :(
# Settings.incudia['relative_url_root']                          ||= ENV['RAILS_RELATIVE_URL_ROOT'] || ''
Settings.incudia['signup_enabled']                             ||= false
Settings.incudia['signin_enabled']                             ||= true if Settings.incudia['signin_enabled'].nil?
Settings.incudia['restricted_visibility_levels']               = Settings.send(:verify_constant_array, Incudia::VisibilityLevel, Settings.incudia['restricted_visibility_levels'], [])
Settings.incudia['username_changing_enabled']                  = true if Settings.incudia['username_changing_enabled'].nil?

# Omniauth
Settings['omniauth'] ||= Settingslogic.new({})
Settings.omniauth['enabled']      = false if Settings.omniauth['enabled'].nil?
Settings.omniauth['providers']  ||= []


# Features for projects.  Will include stuff like messaging, issues, etc.
Settings.incudia['default_projects_features']                  ||= {}
Settings.incudia.default_projects_features['visibility_level'] = Settings.send(:verify_constant, Incudia::VisibilityLevel, Settings.incudia.default_projects_features['visibility_level'], Incudia::VisibilityLevel::PRIVATE)

# Settings['incudia']['extra'] ||= Settingslogic.new({})

if Rails.env.test?
  Settings.incudia['default_can_create_group'] = true
end


