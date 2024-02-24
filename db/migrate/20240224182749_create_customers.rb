# frozen_string_literal: true

class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.string :name, null: false, limit: 250
      t.string :document, null: false, limit: 14
      t.string :state, null: false, limit: 100
      t.string :city, null: false, limit: 100
      t.string :zipcode, null: false, limit: 12
      t.string :address, null: false, limit: 250
      t.string :neighborhood, null: false, limit: 100
      t.datetime :deleted_at

      t.timestamps

      t.index [:document, :deleted_at], unique: true
    end
  end
end
