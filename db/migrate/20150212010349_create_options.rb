class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.integer :survey_id, :null => false
      t.text :content, :null => false

      t.timestamps null: false
    end
  end
end
