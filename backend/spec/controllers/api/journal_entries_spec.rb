require 'rails_helper'

RSpec.describe "Journal Entries API", type: :request do
  before do
    @order = FactoryBot.create(:order, ordered_at: "2023-02-05", price_per_item: 40, quantity: 3, shipping_cost: 8, tax_rate: 0.07)
    FactoryBot.create(:payment, order: @order, amount: 120)
  end

  it "returns monthly journal entries" do
    get "/api/journal_entries", params: { month: "2023-02" }
    expect(response).to have_http_status(:success)
    
    json = JSON.parse(response.body)
    expect(json["month"]).to eq("2023-02")
    expect(json["journal_entries"]).not_to be_empty
  end

  it "returns available months" do
    get "/api/journal_entries/months"
    expect(response).to have_http_status(:success)
    
    json = JSON.parse(response.body)
    expect(json["months"]).to include("2023-02")
  end
end
