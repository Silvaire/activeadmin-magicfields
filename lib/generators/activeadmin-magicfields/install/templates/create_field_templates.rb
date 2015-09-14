class CreateFieldTemplates < ActiveRecord::Migration
  def change
    create_table :field_templates do |t|
      t.string :title
      t.boolean :is_required
      t.string :field_type
      t.references :part, index: true

      t.integer :position

      t.timestamps
    end
  end
end
