class CreateCounters < ActiveRecord::Migration
  def change
    create_table :counters do |t|
      t.string :name
      t.integer :count

      t.timestamps
    end
  end
end
