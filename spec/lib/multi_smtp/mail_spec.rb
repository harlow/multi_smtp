require "spec_helper"

describe MultiSMTP::Mail, "#deliver!" do
  let(:error_notifier) { double(:notifier) }

  before do
    allow(error_notifier).to receive(:notify)
    MultiSMTP.error_notifier = error_notifier
    MultiSMTP.smtp_providers = [
      provider("smtp.sendgrid.net", "sendgrid"),
      provider("smtp.amazaon_ses.com", "amazon_ses")
    ]
  end

  context "primary email provider succeeds" do
    it "sends an email" do
      allow_any_instance_of(Net::SMTP).to receive(:start).and_return(true)

      MultiSMTP::Mail.new({}).deliver!(mail)

      expect(error_notifier).not_to have_received(:notify)
    end
  end

  context "primary email provider fails" do
    it "sends an email with secondary provider" do
      allow_any_instance_of(Net::SMTP).to receive(:start).
        with("test.com", "sendgrid", "password", :login).
        and_raise(Net::SMTPFatalError)

      allow_any_instance_of(Net::SMTP).to receive(:start).
        with("test.com", "amazon_ses", "password", :login).
        and_return(true)

      MultiSMTP::Mail.new({}).deliver!(mail)

      expect(error_notifier).to_not have_received(:notify)
    end
  end

  context "all smtp providers fail" do
    it "notifies airbrake" do
      allow_any_instance_of(Net::SMTP).to receive(:start).
        and_raise(Net::SMTPFatalError)

      MultiSMTP::Mail.new({}).deliver!(mail)

      expect(error_notifier).to have_received(:notify).once
    end
  end

  def mail
    Mail.new(
      delivery_handler: "test",
      from: "from@test.com",
      subject: "test",
      to: "to@test.com"
    )
  end

  def provider(address, user_name)
    {
      address: address,
      authentication: :login,
      domain: "test.com",
      password: "password",
      user_name: user_name
   }
  end
end
