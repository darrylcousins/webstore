require_relative '../../../app/models/webstore/payment_options'

describe Webstore::PaymentOptions do
  let(:customer)        { double('customer') }
  let(:distributor)     { double('distributor') }
  let(:cart)            { double('cart', distributor: distributor, customer: customer) }
  let(:args)            { { cart: cart } }
  let(:payment_options) { Webstore::PaymentOptions.new(args) }

  class PhoneCollection; end
  class PaymentOption; end

  describe '#existing_customer?' do
    it 'returns true if the customer is an existing one' do
      customer.stub(:guest?) { false }
      payment_options.existing_customer?.should be_true
    end
  end

  describe '#address' do
    it 'returns an customers address' do
      address = double('address')
      customer.stub(:address) { address }
      payment_options.address.should eq(address)
    end
  end

  describe '#name' do
    it 'returns an customers name' do
      customer.stub(:guest?) { false }
      customer.stub(:name) { 'name' }
      payment_options.name.should eq('name')
    end
  end

  describe '#phone_number' do
    it 'retuns a customer phone number' do
      customer.stub(:phone_number) { 123 }
      payment_options.phone_number.should eq(123)
    end
  end

  describe '#payment_required?' do
    it 'returns true if there is a payment required' do
      money = double('money', positive?: false)
      payment_options.stub(:closing_balance) { money }
      payment_options.payment_required?.should be_true
    end
  end

  describe '#amount_due' do
    it 'returns the amount due for this order' do
      money = double('money', '*' => -12)
      payment_options.stub(:closing_balance) { money }
      payment_options.amount_due.should eq(-12)
    end
  end

  describe '#only_one_payment_option?' do
    it 'returns true if there is only one payment option for this distributor' do
      distributor.stub(:only_one_payment_option?) { true }
      payment_options.only_one_payment_option?.should be_true
    end
  end

  describe '#collect_phone?' do
    it 'returns true if the distributor requires a phone number' do
      distributor.stub(:collect_phone?) { true }
      payment_options.collect_phone?.should be_true
    end
  end

  describe '#phone_types' do
    it 'returns a list of phone number types' do
      expected_options = [double('tuple1'), double('tuple2')]
      phone_collection_class = double('phone_collection_class', types_as_options: expected_options)
      payment_options.phone_types(phone_collection_class).should eq(expected_options)
    end
  end

  describe '#payment_list' do
    it 'returns a lit of payment options' do
      expected_options = [double('tuple1'), double('tuple2')]
      payment_options_class = double('payment_options_class', options: expected_options)
      payment_options.payment_list(payment_options_class).should eq(expected_options)
    end
  end

  describe '#to_h' do
    it 'returns a hash of the important form data' do
      payment_options.name           = 'name'
      payment_options.phone_number   = '123'
      payment_options.phone_type     = 'phone type'
      payment_options.street_address = '12 St'
      payment_options.suburb         = 'burb'
      payment_options.city           = 'city'
      payment_options.postcode       = '123'
      payment_options.delivery_note  = 'deliver'
      payment_options.payment_method = 'pay method'
      payment_options.complete       = true
      payment_options.to_h.should eq({ email: 'test@example.com', password: 'password' })
    end
  end
end