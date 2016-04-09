class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :name
      t.string :address
      t.string :identification
      t.date :dob
      t.string :phone
      t.string :email
      t.integer :room
      t.integer :rate
      t.integer :days

      t.timestamps null: false
    end

    add_index :invoices, :id, unique: true
  end
end
