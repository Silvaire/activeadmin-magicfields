class Part < ActiveRecord::Base
  has_many :field_templates, dependent: :destroy
  has_many :part_objects, dependent: :destroy
  has_and_belongs_to_many :admin_users
  accepts_nested_attributes_for :field_templates, allow_destroy: true
end
