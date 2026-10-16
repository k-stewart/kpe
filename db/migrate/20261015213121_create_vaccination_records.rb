class CreateVaccinationRecords < ActiveRecord::Migration[8.1]
  def change
    create_table :vaccination_records do |t|
      t.string :name
      t.datetime :due_date
      t.bigint :pterosaur_id
      t.index [ "pterosaur_id" ], name: "index_vaccinations_on_pterosaur"

      t.timestamps
    end
  end
end
