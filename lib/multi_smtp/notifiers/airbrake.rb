module MultiSMTP
  module Notifiers
    module Airbrake
      def self.notify(e, mail)
        Airbrake.notify(e,
          error_message: "Email delivery failed with all SMTP providers.",
          parameters: { mail: extract_mail_params(mail) }
        )
      end

      def self.extract_mail_params(mail)
        {
          delivery_handler: mail.delivery_handler.to_s,
          from: mail.from,
          subject: mail.subject,
          to: mail.to
        }
      end
    end
  end
end
