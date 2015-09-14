class CreatePartObjectFields < ActiveRecord::Migration
  def change
    create_table :part_object_fields do |t|
      t.references :fieldable, polymorphic: true, index: true
      t.integer :position
      t.integer :part_object_id
      t.timestamps
    end
  end
end
