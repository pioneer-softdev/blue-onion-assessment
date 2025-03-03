require 'rails_helper'

RSpec.describe Order, type: :model do
  it "is valid with valid attributes" do
    order = FactoryBot.build(:order)
    expect(order).to be_valid
  end
end
