require 'yaml'

require './lib/promotion_calculator'

class Checkout

  def self.find_by_code(code)
    PRODUCTS.each do |product|
      return product if product["code"] == code
    end
    nil
  end

  class InvalidProductScanned < StandardError
    def initialize
      super("We don't carry this product.")
    end
  end

  PRODUCTS = YAML.load_file('db/products.yml')

  attr_reader :basket

  def initialize
    @basket = []
  end

  def scan(product_code)
    validate_product(product_code)

    basket << product_code
  end

  def total
    total = 0

    basket.each do |pc|
      total += self.class.find_by_code(pc)["price"]
    end

    total
  end

  private

  def validate_product(scanned_product)
    codes = []
    PRODUCTS.each do |product|
      codes << product["code"]
    end

    puts codes.inspect

    if !codes.include?(scanned_product)
      raise InvalidProductScanned.new
    end
  end
end