module Field
  class Image < ActiveRecord::Base
    self.table_name = "field_images"

    before_validation :destroy_image?

    has_one :part_object_field, as: :fieldable
    belongs_to :field_template

    has_attached_file :image, :url => "/active_admin/:class/:attachment/:id/:style_:basename.:extension", :styles => { :medium => "500x500>", :thumb => "100x100>" }
    # include DeletableAttachment

    validates :image, presence: { if: :is_required }
    # validates_attachment_presence :image
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

    delegate :title, to: :field_template, allow_nil: true
    delegate :is_required, to: :field_template, allow_nil: true

    def delete_image
      @delete_image ||= "0"
    end

    def delete_image=(value)
      @delete_image = value
      image_file_name_will_change!
    end

    private

    def destroy_image?
      self.image.clear if @delete_image == "1"
    end
  end
end