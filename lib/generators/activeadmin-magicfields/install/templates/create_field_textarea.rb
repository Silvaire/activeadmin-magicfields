class CreateFieldTextarea < ActiveRecord::Migration
  def change
    create_table :field_textareas do |t|
      t.string :title
      t.text :textarea
      t.integer :field_template_id

      t.timestamps
    end
  end
end

