require 'spec_helper'

describe Checkout do
  let(:products_array) { YAML.load_file("spec/support/products.yml") }
  let(:product_code) { products_array.first["code"] }
  let(:product_code_two) { products_array[1]["code"] }

  before do
    stub_const("Checkout::PRODUCTS", products_array)
  end

  subject { described_class.new }

  describe "#scan" do

    before do
      co = subject
      co.scan(product_code)
    end

    it "adds an item to the basket" do
      expect(subject.basket.size).to eq 1
    end

    context "when an invalid product is added" do
      let(:invalid_product_code) { "123" }

      it "raises an error" do
        co = subject
        expect { co.scan(invalid_product_code) }.to raise_error Checkout::InvalidProductScanned
      end
    end
  end

  describe "#total" do
    let(:co) { subject }

    before do
      co.scan(product_code)
      co.scan(product_code_two)
    end

    it "sums the basket correctly" do
      puts "_________"
      puts co.basket
      expect(co.total).to eq 9
    end
  end
end