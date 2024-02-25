# frozen_string_literal: true

class AddBarcodeAndBankAndExternalIdToBankslips < ActiveRecord::Migration[7.1]
  def up
    add_column :bankslips, :barcode, :string, null: false
    add_column :bankslips, :external_id, :string, null: false
    add_column :bankslips, :bank, :string

    add_index :bankslips, :barcode, unique: true
    add_index :bankslips, :external_id, unique: true
  end

  def down
    remove_columns(:bankslips, :barcode, :external_id, :bank)
  end
end
