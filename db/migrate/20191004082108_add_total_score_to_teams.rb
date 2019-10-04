class AddTotalScoreToTeams< ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :total_score, :integer, :default => 0
  end
end
