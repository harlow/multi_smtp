require "mail"

module MultiSMTP
  class Mail < Mail::SMTP
    def initialize(default_settings)
      @default_settings = default_settings
    end

    def deliver!(mail)
      smtp_providers.each_with_index do |smtp_provider, index|
        self.settings = default_settings.merge(smtp_provider)

        begin
          super(mail)
          break
        rescue Exception => e
          next unless all_providers_failed?(index)

          if error_notifier
            error_notifier.notify(mail)
          else
            raise e
          end
        end
      end
    end

    private

    def smtp_providers
      @smtp_providers ||= MultiSMTP.smtp_providers
    end

    def error_notifier
      @error_notifier ||= MultiSMTP.error_notifier
    end

    def all_providers_failed?(index)
      (smtp_providers.size - 1) == index
    end

    attr_reader :default_settings
  end
end
