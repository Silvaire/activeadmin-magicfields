# ActiveadminMagicfields

Activeadmin Magicfields gem is made to bring simple sections and custom field support into your ActiveAdmin. It aims to bring some of Wordpress' [Advanced Custom Fields](http://www.advancedcustomfields.com/) plugin features to Active Admin. Its development was greatly inspired by Petr Sergeev's and Sindre Moen's `activeadmin_polymorphic` [gem](https://github.com/hyperoslo/activeadmin_polymorphic).

This gem includes a lot of hacks and tricks, and has been developed mainly as an experiment. Use carefully and at your own risk.

Installing the gem enables the user to create section templates (called parts) straight from the admin panel, defining which field types should be included in a part.

![http://i.imgur.com/XJbuHXx.png]

Then, users can add parts to Active Admin models with the click of a button, and simply feel in their content.

![http://i.imgur.com/mQ0vSGb.png]

# Features

* Part creation from custom fields (default field types are: text, textarea, image, checkbox and repeater. See down to add your own field types)
* Add parts and content to Active Admin model
* Form Validation 
* Sortable behaviour
* File uploads

# Installation

Add this to your Gemfile:

``` ruby
gem "activeadmin-magicfields"
```

and run `bundle install`, then `rails g activeadmin-magicfields:install`, and finally `rake db:migrate`.

Include assets in js and css manifests

```
# assets/javascripts/active_admin.js.coffee
# ...
#= require activeadmin-magicfields
# ...

// assets/stylesheets/active_admin.scss
// ...
@import "activeadmin-magicfields";
// ...
```

# Usage

To use the gem, you need to enable parts on one of your models

```
# db/migrate
class CreateYourModelsParts < ActiveRecord::Migration
  def change
    create_table :your_models_parts do |t|
      t.integer :your_model_id
      t.integer :part_id
    end
  end
end
```

```
# models/your_model.rb
class YourModel < ActiveRecord::Base
  # ...

  has_many :part_objects, dependent: :destroy, inverse_of: :base_model, foreign_key: "base_model_id"
  has_and_belongs_to_many :parts
  accepts_nested_attributes_for :part_objects, allow_destroy: true

  # ...
end
```


The gem extends activeadmin's form builder, so to enable it you need to override the form builder using `builder` option:

```
#admin/your_model.rb
ActiveAdmin.register YourModel do
  # ...

  form builder: ActiveadminMagicfields::FormBuilder, html: { :enctype => "multipart/form-data" } do |f|
    f.inputs do
      # ...
      f.sections_has_many :parts, collection: Part.includes(:field_templates).all, part_objects: resource.part_objects, sortable: :position
    end
    f.actions
  end

  # ...
end
```

There are few parameters available, currently none of which can be changed:
* the first is the name of the parts association
* the second parameter refers to the available parts (previously created in the admin panel)
* `sortable` - enables drag'n'drop for parts

# Adding a custom field type

To add a custom field type, just create a table called 'field_[your_field_type]s', a model in models/field/your_field_type.rb, and a form partial. This will enable you to use your_field_type as a part's custom field.

```
# db/migrate
class CreateFieldYourFieldType < ActiveRecord::Migration
  def change
    create_table :field_your_field_types do |t|
      t.string :title #required for all field types
      t.integer :field_template_id #required for all field types

      t.[some_database_type] :your_field_type

      t.timestamps
    end
  end
end
```

```
# models/field/your_field_type.rb
module Field
  class YourFieldType < ActiveRecord::Base
    self.table_name = "field_your_field_types"

    has_one :part_object_field, as: :fieldable
    belongs_to :field_template

    delegate :title, to: :field_template, allow_nil: true
    delegate :is_required, to: :field_template, allow_nil: true

    validates :your_field_type, presence: { if: :is_required }

  end
end
```

```
<%# views/admin/field_inputs/_your_field_type.html.erb %>
<%= builder.input field_template.field_type, label: field_template.title, required: field_template.is_required, input_html: {name: form_prefix + builder.object_name.sub('part[', '[') + "[#{field_template.field_type}]" } %>
```

# Testing

As this gem was created the quick'n'dirty way as a fast experiment, tests are not up-to-date at all.

# In plan

* Fix strong parameters (currently, the gem accepts any parameters submission)
* Namespace everything to avoid conflicts
* Make proper tests
* Make more thing customizable (eg. the names 'parts' and 'part_objects' could be defined by user)
* Improve the form UI, currently pretty raw.
* Repeater fields could allow a selection of parts (or define their own).

# License

[MIT](LICENSE.txt)
