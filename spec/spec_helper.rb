$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "lib")
$LOAD_PATH << File.join(File.dirname(__FILE__))

require "rubygems"
require "rspec"
require "pry"
require "multi_smtp"

RSpec.configure do |config|
  config.after :each do
    MultiSMTP.smtp_providers = nil
  end
end
