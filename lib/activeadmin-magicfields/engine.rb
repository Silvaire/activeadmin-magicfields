module ActiveadminMagicfields
  class Engine < ::Rails::Engine
    isolate_namespace ActiveadminMagicfields

    initializer "register resource" do
      ActiveAdmin.application.load_paths += [ File.expand_path('../app/admin', File.dirname(__FILE__)) ]
    end

    paths["app/views"] << "lib/app/views"

  end
end
