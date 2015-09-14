class CreatePartObjects < ActiveRecord::Migration
  def change
    create_table :part_objects do |t|
      
      t.integer :base_model_id
      t.integer :part_id
      t.integer :position

      t.timestamps

    end
  end
end
