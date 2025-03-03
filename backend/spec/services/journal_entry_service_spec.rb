require 'rails_helper'

RSpec.describe JournalEntryService, type: :service do
  before do
    @order1 = FactoryBot.create(:order, ordered_at: "2023-01-10", price_per_item: 50, quantity: 2, shipping_cost: 10, tax_rate: 0.1)
    @order2 = FactoryBot.create(:order, ordered_at: "2023-01-15", price_per_item: 30, quantity: 3, shipping_cost: 5, tax_rate: 0.08)
    FactoryBot.create(:payment, order: @order1, amount: 120)
    FactoryBot.create(:payment, order: @order2, amount: 102.2)
  end

  it "calculates correct journal entries for a given month" do
    result = JournalEntryService.generate_monthly_journal_entries("2023-01")

    expect(result[:month]).to eq("2023-01")
    expect(result[:total][:debit]).to eq(result[:total][:credit])

    account_names = result[:journal_entries].map { |entry| entry[:account] }
    expect(account_names).to include("Accounts Receivable", "Revenue", "Shipping Revenue", "Sales Tax Payable", "Cash")
  end
end
