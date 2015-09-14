class PartObject < ActiveRecord::Base
  
  has_many :part_object_fields, class_name: "PartObjectField", foreign_key: "part_object_id", dependent: :destroy
  # belongs_to :base_model, inverse_of: :part_objects, foreign_key: "base_model_id"
  belongs_to :part
  
  accepts_nested_attributes_for :part_object_fields, allow_destroy: true

  scope :by_position, -> { order('position ASC') }
  
end
