require_relative '../lib/store'

RSpec.describe Store do
  let(:content) do
    "VOUCHER/Cabify Voucher/5.00\nTSHIRT/Cabify T-Shirt/20.00\nMUG/Cabify Coffe Mug/7.50"
  end
  let!(:store) { Store.new("bd/db_products.txt") }
  describe "#load_products" do
    before do
      allow(File).to receive(:open).with(any_args).and_return(content)
      store.load_products
      @product = store.products["TSHIRT"]
    end

    it { expect(store.products.length).to eq(3) }
    it { expect(@product.code).to eq("TSHIRT") }
    it { expect(@product.name).to eq("Cabify T-Shirt") }
    it { expect(@product.price).to eq(20.00) }
  end
end
