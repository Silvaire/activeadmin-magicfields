class CreateFieldCheckbox < ActiveRecord::Migration
  def change
    create_table :field_checkboxes do |t|
      t.string :title
      t.boolean :checkbox
      t.integer :field_template_id
      t.timestamps
    end
  end
end
