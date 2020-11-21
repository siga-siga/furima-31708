class CreatePurchaseForms < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_forms do |t|
      t.timestamps
    end
  end
end
