class AddProlinkToPlayer< ActiveRecord::Migration[5.2]
  def change
    add_column :players, :viadeo, :string
    add_column :players, :linkedin, :string
  end
end
