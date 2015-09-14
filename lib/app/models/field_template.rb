class FieldTemplate < ActiveRecord::Base
  belongs_to :part

  scope :by_position, -> { order('position ASC') }
end
