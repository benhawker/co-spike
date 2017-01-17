require 'spec_helper'

describe PromotionCalculator do
  let(:products_array) { YAML.load_file("spec/support/products.yml") }
  let(:promotions_array) { YAML.load_file("spec/support/promotions.yml") }

  before do
    stub_const("Checkout::PRODUCTS", products_array)
    stub_const("PromotionCalculator::PROMOTIONS", promotions_array)
  end


  let(:basket) { ["SF1", "SF1"] }
  subject { described_class.new(basket) }

  describe "#calculate" do
    it "returns the discount total" do
      expect(subject.calculate).to eq 4
    end
  end
end