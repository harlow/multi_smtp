require "spec_helper"

describe MultiSMTP, ".smtp_providers" do
  it "returns an array of providers" do
    MultiSMTP.smtp_providers = [:provider1, :provider2]

    result = MultiSMTP.smtp_providers

    expect(result).to eq [:provider1, :provider2]
  end

  context "no providers set" do
    it "raises and exception" do
      expect { MultiSMTP.smtp_providers }.to raise_exception
    end
  end
end
