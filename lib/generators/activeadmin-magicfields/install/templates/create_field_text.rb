class CreateFieldText < ActiveRecord::Migration
  def change
    create_table :field_texts do |t|
      t.string :title
      t.string :text
      t.integer :field_template_id
      t.timestamps
    end
  end
end
