class CreateRepeaterPartObjects < ActiveRecord::Migration
  def change
    create_table :repeater_part_objects do |t|
      t.references :part_object, index: true
      t.references :field_repeater, index: true

      t.timestamps
    end
  end
end
