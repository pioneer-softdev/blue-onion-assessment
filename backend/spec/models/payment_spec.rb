require 'rails_helper'

RSpec.describe Payment, type: :model do
  it "associates with an order" do
    payment = FactoryBot.create(:payment)
    expect(payment.order).to be_present
  end
end
