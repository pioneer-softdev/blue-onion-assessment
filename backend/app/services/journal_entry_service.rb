class JournalEntryService
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

    # Sales Entry
    journal_entries << {
      account: "Accounts Receivable",
      debit: total_sales,
      credit: 0,
      description: "Cash expected for orders"
    }
    journal_entries << {
      account: "Revenue",
      debit: 0,
      credit: total_sales,
      description: "Revenue for orders"
    }

    # Shipping Entry
    journal_entries << {
      account: "Shipping Accounts Receivable",
      debit: total_shipping,
      credit: 0,
      description: "Cash expected for shipping on orders",
    }
    journal_entries << {
      account: "Shipping Revenue",
      debit: 0,
      credit: total_shipping,
      description: "Revenue for shipping",
    }

    # Tax Entry
    journal_entries << {
      account: "Tax Receivable",
      debit: total_tax,
      credit: 0,
      description: "Cash expected for taxes",
    }
    journal_entries << {
      account: "Sales Tax Payable",
      debit: 0,
      credit: total_tax,
      description: "Cash to be paid for sales tax",
    }

    # Payments Entry
    journal_entries << {
      account: "Cash",
      debit: total_payments,
      credit: 0,
      description: "Cash received"
    }
    journal_entries << {
      account: "Accounts Receivable",
      debit: 0,
      credit: total_payments,
      description: "Removal of expectation of cash"
    }

    # Compute total debits & credits for validation
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
end
