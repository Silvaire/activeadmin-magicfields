ActiveAdmin.register PartObject do

  menu false

  FIELDABLES = Field.constants.select {|c| Field.const_get(c).is_a? Class }.map {|f| Field.const_get(f) }

  form builder: ActiveadminMagicfields::FormBuilder, :html => { :'data-type' => :json, :enctype => "multipart/form-data", :remote => true } do |f|
    f.inputs do
      f.input :base_model_id, as: :hidden
      f.magicfields_has_many :part_object_fields, :fieldable, types: FIELDABLES, sortable: :position, allow_destroy: true
    end
    f.actions
  end

  # permit_params do
  #   permitted = PartObject.new.attributes.keys | [:id, part_object_fields_attributes: [:id, :fieldable_type, :fieldable_id, :position, :_destroy, fieldable_attributes: [:id] ] ]
  #   permitted
  # end

  controller do
    def permitted_params
      params.permit!
    end
  end

end