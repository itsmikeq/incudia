module TestEnv
  extend self
  def init(opts = {})
    RSpec::Mocks::setup

    # Disable mailer for spinach tests
    disable_mailer if opts[:mailer] == false

  end

  def disable_mailer
    NotificationService.any_instance.stub(mailer: double.as_null_object)
  end

  def enable_mailer
    NotificationService.any_instance.unstub(:mailer)
  end

end