require_relative '../lib/checkout'
require_relative '../lib/rules/rules_set'

RSpec.describe Checkout do
  let(:pricing_rules) { RulesSet.new }
  let(:co) { described_class.new(pricing_rules) }
  let(:content) do
    "VOUCHER/Cabify Voucher/5.00\nTSHIRT/Cabify T-Shirt/20.00\nMUG/Cabify Coffe Mug/7.50"
  end

  describe "#scan" do
    before do
      allow(File).to receive(:open).with(any_args).and_return(content)
      co
    end
    it { expect(co.scan("TSHIRT")).to eq("Product scanned") }
    it { expect(co.scan("WRONG")).to eq("Product doesn't exist, try another code") }
  end

  describe "#total" do
    context "example 1" do
      before do
        co
        co.scan("VOUCHER")
        co.scan("TSHIRT")
        co.scan("MUG")
      end

      it { expect(co.total).to eq(32.5) }
    end

    context "example 2" do
      before do
        co
        co.scan("VOUCHER")
        co.scan("TSHIRT")
        co.scan("VOUCHER")
      end

      it { expect(co.total).to eq(25.0) }
    end

    context "example 3" do
      before do
        co
        co.scan("TSHIRT")
        co.scan("TSHIRT")
        co.scan("TSHIRT")
        co.scan("VOUCHER")
        co.scan("TSHIRT")
      end

      it { expect(co.total).to eq(81.0) }
    end

    context "example 4" do
      before do
        co
        co.scan("VOUCHER")
        co.scan("TSHIRT")
        co.scan("VOUCHER")
        co.scan("VOUCHER")
        co.scan("MUG")
        co.scan("TSHIRT")
        co.scan("TSHIRT")
      end

      it { expect(co.total).to eq(74.5) }
    end
  end
end
