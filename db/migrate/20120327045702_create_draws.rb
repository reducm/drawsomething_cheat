class CreateDraws < ActiveRecord::Migration
  def change
    create_table :draws do |t|
      t.string :english
      t.string :chinese
      t.timestamps
    end
  end
end
