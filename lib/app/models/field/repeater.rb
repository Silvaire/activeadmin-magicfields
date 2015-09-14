module Field
  class Repeater < ActiveRecord::Base
    self.table_name = "field_repeaters"

    has_many :repeater_part_objects, class_name: "RepeaterPartObject", inverse_of: "field_repeater", foreign_key: "field_repeater_id", dependent: :destroy
    has_many :part_objects, through: :repeater_part_objects, dependent: :destroy

    has_many :parts

    belongs_to :field_template

    delegate :title, to: :field_template, allow_nil: true
    delegate :is_required, to: :field_template, allow_nil: true
    
    accepts_nested_attributes_for :repeater_part_objects, allow_destroy: true
    accepts_nested_attributes_for :part_objects, allow_destroy: true

  end
end