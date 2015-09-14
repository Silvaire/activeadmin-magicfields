module Field
  class Textarea < ActiveRecord::Base
    self.table_name = "field_textareas"

    has_one :part_object_field, as: :fieldable
    belongs_to :field_template

    delegate :title, to: :field_template, allow_nil: true
    delegate :is_required, to: :field_template, allow_nil: true

    validates :textarea, presence: { if: :is_required }

  end
end