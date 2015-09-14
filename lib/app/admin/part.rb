ActiveAdmin.register Part do

  form do |f|
    f.inputs "Part" do
      f.input :name
    end

    f.inputs "Fields" do
      f.has_many :field_templates, sortable: :position, allow_destroy: true do |a|
        a.input :title
        a.input :field_type, as: :select, collection: Field.constants.select {|c| Field.const_get(c).is_a? Class }.map { |f| f.to_s.underscore}
        a.input :is_required
      end
    end

    f.actions
  end

  member_action :serialized, :method => :get do
    render resource
  end

  controller do
    def permitted_params
      params.permit!
    end
  end

end
