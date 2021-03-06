# frozen_string_literal: true

require "draper"
require_relative "../models/customer"

class CustomerDecorator < Draper::Decorator
  delegate_all

  GUEST_NAME = "Guest"

  def id
    object.existing_customer_id
  end

  def balance_threshold
    object.balance_threshold.format
  end

  def name
    object.guest? ? GUEST_NAME : object.name
  end
end
