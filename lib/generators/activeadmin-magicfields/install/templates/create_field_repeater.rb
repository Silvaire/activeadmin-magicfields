class CreateFieldRepeater < ActiveRecord::Migration
  def change
    create_table :field_repeaters do |t|
      t.string :title
      t.integer :field_template_id
      t.timestamps
    end
  end
end
