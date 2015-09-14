class CreateFieldImage < ActiveRecord::Migration
  def change
    create_table :field_images do |t|
      t.has_attached_file :image
      t.string :title
      t.integer :field_template_id
      t.timestamps
    end
  end
end
