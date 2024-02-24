# frozen_string_literal: true

class CreateBankslips < ActiveRecord::Migration[7.1]
  def up
    create_table :bankslips, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.string :status, null: false, default: :opened
      t.datetime :expire_at, null: false
      t.integer :amount, null: false
      t.string :gateway, null: false
      t.references :customer, type: :uuid

      t.timestamps
    end

    add_check_constraint :bankslips, "status = any(array['opened', 'overdue', 'canceled', 'expired'])"
    add_check_constraint :bankslips, "gateway = 'kobana'"
  end

  def down
    drop_table :bankslips
  end
end
