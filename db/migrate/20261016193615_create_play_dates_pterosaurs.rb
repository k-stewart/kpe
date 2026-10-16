class CreatePlayDatesPterosaurs < ActiveRecord::Migration[8.1]
  def change
    create_table :play_dates_pterosaurs, id: false do |t|
      t.belongs_to :play_date
      t.belongs_to :pterosaur

      t.timestamps
    end
  end
end
