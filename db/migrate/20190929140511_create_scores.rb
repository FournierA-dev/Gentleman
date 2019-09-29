class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.integer :score
      t.references :match, foreign_key: true
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
