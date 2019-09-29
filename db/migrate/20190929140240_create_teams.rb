class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :total_score
      t.references :pool, foreign_key: true

      t.timestamps
    end
  end
end
