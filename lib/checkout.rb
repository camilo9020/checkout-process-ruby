require_relative 'store'
require_relative 'order'

class Checkout
  attr_reader :order, :total, :store

  def initialize
    @store = Store.new
    @order = Order.new
    @total = 0.00
  end

  def scan(code)
    product = @store.products[code]
    if product
      @order.add_item(product)
      "Product scanned"
    else
      "Product doesn't exist, try another code"
    end
  end

  def total
    @order.items.each do |_key, item|
      @total += (item.unit_price * item.quantity - item.discount).round(2)
    end
    @total
  end
end