class RepeaterPartObject < ActiveRecord::Base
  belongs_to :part_object, dependent: :destroy 
  belongs_to :field_repeater, class_name: "Field::Repeater", inverse_of: "repeater_part_objects", foreign_key: "field_repeater_id"

  accepts_nested_attributes_for :part_object, allow_destroy: true
end