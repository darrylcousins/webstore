require "draper"
require_relative "../../models/webstore/cart"

class Webstore::CartDecorator < Draper::Decorator
  delegate_all

  def current_balance
    object.current_balance
  end

  def closing_balance
    object.closing_balance
  end

  def order_price
    object.order_price
  end

  def amount_due
    object.amount_due.with_currency(context[:currency])
  end
end
