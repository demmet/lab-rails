class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.string :wirecard_id
      t.id :status

      t.timestamps
    end
  end
end
