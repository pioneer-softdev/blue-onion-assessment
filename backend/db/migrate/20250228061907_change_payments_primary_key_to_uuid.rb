class ChangePaymentsPrimaryKeyToUuid < ActiveRecord::Migration[6.1]
  def change
    # Remove the existing integer-based ID
    remove_column :payments, :id, :bigint

    # Add a new UUID-based primary key
    add_column :payments, :id, :uuid, default: -> { "gen_random_uuid()" }, primary_key: true
  end
end
