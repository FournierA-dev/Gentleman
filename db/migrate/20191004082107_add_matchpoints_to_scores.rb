class AddMatchpointsToScores < ActiveRecord::Migration[5.2]
  def change
    add_column :scores, :match_point, :integer, :default => 0
    remove_column :teams, :total_score
  end
end
