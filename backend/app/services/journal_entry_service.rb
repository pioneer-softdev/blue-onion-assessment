class JournalEntryService
  ACCOUNTS = {
    accounts_receivable: "Accounts Receivable",
    revenue: "Revenue",
    shipping_accounts_receivable: "Shipping Accounts Receivable",
    shipping_revenue: "Shipping Revenue",
    tax_receivable: "Tax Receivable",
    sales_tax_payable: "Sales Tax Payable",
    cash: "Cash"
  }.freeze

  DESCRIPTIONS = {
    sales: "Cash expected for orders",
    sales_revenue: "Revenue for orders",
    shipping: "Cash expected for shipping on orders",
    shipping_revenue: "Revenue for shipping",
    tax: "Cash expected for taxes",
    tax_payable: "Cash to be paid for sales tax",
    payments: "Cash received",
    payments_removal: "Removal of expectation of cash"
  }.freeze

  def self.generate_monthly_journal_entries(month)
    start_date = Date.parse("#{month}-01")
    end_date = start_date.end_of_month

    orders = Order.where(ordered_at: start_date..end_date)
    payments = Payment.where(order_id: orders.pluck(:id))

    total_sales = orders.sum("price_per_item * quantity").to_f
    total_shipping = orders.sum(:shipping_cost).to_f
    total_tax = orders.sum("price_per_item * quantity * tax_rate").to_f
    total_payments = payments.sum(:amount).to_f

    journal_entries = []
    journal_entries.concat(generate_journal_entry(ACCOUNTS[:accounts_receivable], total_sales, 0, DESCRIPTIONS[:sales]))
    journal_entries.concat(generate_journal_entry(ACCOUNTS[:revenue], 0, total_sales, DESCRIPTIONS[:sales_revenue]))
    journal_entries.concat(generate_journal_entry(ACCOUNTS[:shipping_accounts_receivable], total_shipping, 0, DESCRIPTIONS[:shipping]))
    journal_entries.concat(generate_journal_entry(ACCOUNTS[:shipping_revenue], 0, total_shipping, DESCRIPTIONS[:shipping_revenue]))
    journal_entries.concat(generate_journal_entry(ACCOUNTS[:tax_receivable], total_tax, 0, DESCRIPTIONS[:tax]))
    journal_entries.concat(generate_journal_entry(ACCOUNTS[:sales_tax_payable], 0, total_tax, DESCRIPTIONS[:tax_payable]))
    journal_entries.concat(generate_journal_entry(ACCOUNTS[:cash], total_payments, 0, DESCRIPTIONS[:payments]))
    journal_entries.concat(generate_journal_entry(ACCOUNTS[:accounts_receivable], 0, total_payments, DESCRIPTIONS[:payments_removal]))

    total_debits = journal_entries.sum { |entry| entry[:debit] }
    total_credits = journal_entries.sum { |entry| entry[:credit] }

    {
      month: month,
      journal_entries: journal_entries,
      total: {
        debit: total_debits,
        credit: total_credits
      }
    }
  end

  def self.get_available_months
    months = Order.distinct.pluck(Arel.sql("TO_CHAR(ordered_at, 'YYYY-MM')")).uniq
    months.sort.reverse
  end

  private

  def self.generate_journal_entry(account, debit, credit, description)
    [{
      account: account,
      debit: debit,
      credit: credit,
      description: description
    }]
  end
end
