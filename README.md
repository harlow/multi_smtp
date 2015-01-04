# MultiSMTP

Email delivery is a critical component of many web applications. Often
third-party Email services can experience temporary downtime.

We can achieve automatic failover by overriding the default delivery method with the
MultiSMTP class.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "multi_smtp"
```

And then execute:

    $ bundle

## Configuration

Set the delivery method to `:multi_smtp` for each environment that should use
the automatic failover.

```ruby
# config/environments/{staging,production}.rb
ExampleApp::Application.configure do
  config.action_mailer.delivery_method = :multi_smtp
end
```

In an initializer configure the MultiSMTP class with an array of (1..N) SMTP
Providers.

```ruby
# config/initializers/multi_smtp.rb
sendgrid_settings = {
  address: 'smtp.sendgrid.net',
  authentication: :plain,
  domain: 'hoteltonight.com',
  password: ENV['SENDGRID_PASSWORD'],
  port: '587',
  user_name: ENV['SENDGRID_USERNAME'],
}

other_smtp_settings = {
  # Other SMTP settings
}

MultiSMTP.smtp_providers = [sendgrid_settings, other_smtp_settings]
```

## Error Notifications

If all SMTP providers fail the default behavior is to re-raise the original exception.
However, we can also specify custom notifications.

```ruby
# config/initializers/multi_smtp.rb
require "multi_smtp/notifiers/airbrake"

MultiSMTP.error_notifier = MultiSMTP::Notifiers::Airbrake
```

If there is another type of notification you'd like to receive, you can create a
new notifier that implements the class method `.notify`.

```ruby
class MyCustomNotifier
  def self.notify(mail)
    # do something special
  end
end

MultiSMTP.error_notifier = MyCustomNotifier
```

See the [Airbrake Notifier][1] for more details.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/multi_smtp/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[1]: https://github.com/harlow/multi_smtp/blob/master/lib/multi_smtp/notifiers/airbrake.rb
