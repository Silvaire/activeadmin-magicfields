require 'rails/generators/migration'

module ActiveadminMagicfields
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)
      desc "add the migrations"

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def copy_migrations
        migration_template "create_parts.rb", "db/migrate/create_parts.rb"
        migration_template "create_part_objects.rb", "db/migrate/create_part_objects.rb"
        migration_template "create_part_object_fields.rb", "db/migrate/create_part_object_fields.rb"
        migration_template "create_field_templates.rb", "db/migrate/create_field_templates.rb"
        migration_template "create_field_text.rb", "db/migrate/create_field_text.rb"
        migration_template "create_field_image.rb", "db/migrate/create_field_image.rb"
        migration_template "create_field_textarea.rb", "db/migrate/create_field_textarea.rb"
        migration_template "create_field_checkbox.rb", "db/migrate/create_field_checkbox.rb"
        migration_template "create_field_repeater.rb", "db/migrate/create_field_repeater.rb"
        migration_template "create_repeater_part_objects.rb", "db/migrate/create_repeater_part_objects.rb"
      end
    end
  end
end