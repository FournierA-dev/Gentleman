class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.datetime :date

      t.timestamps
    end
  end
end
