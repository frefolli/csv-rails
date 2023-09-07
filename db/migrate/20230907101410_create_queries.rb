class CreateQueries < ActiveRecord::Migration[7.0]
  def change
    create_table :queries do |t|
      t.string :name
      t.timestamp :timestamp

      t.timestamps
    end
  end
end
