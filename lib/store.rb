require_relative 'product'

class Store
  attr_reader :products

  def initialize(file_path)
    @file_path = file_path
    @products = {}
  end

  def load_products
    file = File.open(root_path, 'r')
    file.each_line do |line|
      row = line.delete("\n").split("/")
      add_product(Product.new(row[0], row[1], row[2].to_f))
    end
  end

  def add_product(product)
    products[product.code] = product
  end

  private

  def root_path
    File.join(File.dirname(__FILE__), @file_path)
  end
end
