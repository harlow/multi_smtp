require "multi_smtp/mail"
require "multi_smtp/version"

module MultiSMTP
  def self.error_notifier=(notifier)
    @error_notifier = notifier
  end

  def self.error_notifier
    @error_notifier || false
  end

  def self.smtp_providers=(providers)
    @smtp_providers = providers
  end

  def self.smtp_providers
    @smtp_providers || raise("MultiSMTP Error: Please specify smtp_providers.")
  end
end

if defined?(Rails)
  ActionMailer::Base.add_delivery_method(:multi_smtp, MultiSMTP::Mail)
end
