class CreatePterosaurs < ActiveRecord::Migration[8.1]
  def change
    create_table :pterosaurs do |t|
      t.string :name
      t.string :species
      t.bigint :owner_id
      t.index [ "owner_id" ], name: "index_pterosaur_on_owner"

      t.timestamps
    end
  end
end
