class PartObjectField < ActiveRecord::Base

  belongs_to :part_object, class_name: "PartObject", foreign_key: "part_object_id"
  belongs_to :fieldable, polymorphic: true, dependent: :destroy

  validates :fieldable, presence: true
  accepts_nested_attributes_for :fieldable, allow_destroy: true

  def build_fieldable(attributes, options = {})
    self.fieldable = fieldable_type.constantize.new(attributes, options)
  end

end