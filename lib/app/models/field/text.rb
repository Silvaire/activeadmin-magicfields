module Field
  class Text < ActiveRecord::Base
    self.table_name = "field_texts"

    has_one :part_object_field, as: :fieldable
    belongs_to :field_template

    delegate :title, to: :field_template, allow_nil: true
    delegate :is_required, to: :field_template, allow_nil: true

    validates :text, presence: { if: :is_required }

  end
end