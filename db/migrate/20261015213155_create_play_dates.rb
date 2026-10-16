class CreatePlayDates < ActiveRecord::Migration[8.1]
  def change
    create_table :play_dates do |t|
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
