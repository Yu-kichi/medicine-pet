class AddPrefectureIdToClinics < ActiveRecord::Migration[6.0]
  def change
    add_reference :clinics, :prefecture, foreign_key: true
  end
end
