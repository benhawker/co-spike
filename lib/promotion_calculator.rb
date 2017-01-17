require './lib/checkout'

class PromotionCalculator

  PROMOTIONS = YAML.load_file("db/promotions.yml")
  PRODUCTS = YAML.load_file('db/products.yml')

  attr_reader :basket

  def initialize(basket)
    @basket = basket
  end

  def calculate
    bogof
  end

  private

  def bogof
    discount = 0
    promos = PROMOTIONS.select { |promo| promo["type"] == "BOGOF" }

    promos.each do |promo|
      if basket.count(promo["code"]) == 2
        discount += Checkout.find_by_code(promo["code"])["price"]
      end
    end
    discount
  end
end