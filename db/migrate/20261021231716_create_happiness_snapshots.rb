class CreateHappinessSnapshots < ActiveRecord::Migration[8.1]
  def change
    create_table :happiness_snapshots do |t|
      t.float "percent_happy"
      t.json "sad_reasons"

      t.timestamps
    end
  end
end
