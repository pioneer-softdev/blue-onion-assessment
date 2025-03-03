require 'csv'

namespace :import do
  desc "Import orders and payments from data.csv"
  task orders_and_payments: :environment do
    file_path = Rails.root.join("data.csv")

    unless File.exist?(file_path)
      puts "❌ Error: data.csv not found!"
      exit
    end

    puts "🚀 Importing Orders and Payments from data.csv..."
    ActiveRecord::Base.transaction do
      CSV.foreach(file_path, headers: true) do |row|

        order = Order.find_or_create_by!(
          id: row["order_id"]
        ) do |o|
          o.ordered_at = Date.strptime(row["ordered_at"], "%Y-%m-%d")
          o.item_type = row["item_type"]
          o.price_per_item = row["price_per_item"].to_f
          o.quantity = row["quantity"].to_i
          o.shipping_cost = row["shipping"].to_f
          o.tax_rate = row["tax_rate"].to_f
        end

        def create_payment(payment_id, amount, order)
          return if payment_id.nil? || payment_id.strip.empty? || payment_id.strip == "0"
          Payment.find_or_create_by!(id: payment_id.strip) do |p|
            p.order = order
            p.amount = amount.to_f
            p.payment_method = "Unknown"
          end
        end

        create_payment(row["payment_1_id"], row["payment_1_amount"], order)
        create_payment(row["payment_2_id"], row["payment_2_amount"], order)
      end
    end

    puts "✅ Import completed successfully!"
  end
end