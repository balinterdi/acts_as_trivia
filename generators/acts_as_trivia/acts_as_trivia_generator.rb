class ActsAsTriviaGenerator < Rails::Generator::NamedBase # ControllerGenerator
  
  # this is snatched from the resource generator in the Rails source
  default_options :skip_timestamps => false, :skip_migration => false

  attr_reader   :controller_name,
                :controller_class_path,
                :controller_file_path,
                :controller_class_nesting,
                :controller_class_nesting_depth,
                :controller_class_name,
                :controller_singular_name,
                :controller_plural_name
  alias_method  :controller_file_name,  :controller_singular_name
  alias_method  :controller_table_name, :controller_plural_name

  def initialize(runtime_args, runtime_options = {})
    super

    @controller_name = @name.pluralize

    base_name, @controller_class_path, @controller_file_path, @controller_class_nesting, @controller_class_nesting_depth = extract_modules(@controller_name)
    @controller_class_name_without_nesting, @controller_singular_name, @controller_plural_name = inflect_names(base_name)

    if @controller_class_nesting.empty?
      @controller_class_name = @controller_class_name_without_nesting
    else
      @controller_class_name = "#{@controller_class_nesting}::#{@controller_class_name_without_nesting}"
    end
  end
  
  def manifest
    record do |m|
      # Check whether the given class names are already taken by
      # Ruby or Rails.  In the future, expand to check other namespaces
      # such as the rest of the user's app.
      m.class_collisions "Trivia", "TriviasController", "TriviaTest"
      
      # Controller, helper, views, and spec directories.
      m.directory 'app/models/trivias'
      m.directory 'app/controllers/trivias'
      m.directory 'app/helpers/trivias'
      m.directory 'app/views/trivias'
      m.directory 'test/functional/trivias'
      m.directory 'test/units/trivias'
      
      m.template 'model.rb', 'app/models/trivia.rb'
      
      # Controller spec, class, and helper.
      m.template 'controller.rb', 'app/controllers/trivias_controller.rb'
      
      m.route_resources "trivia" # singular_name
      
      unless options[:skip_migration]
        m.migration_template 'trivias_migration.rb', 'db/migrate', :assigns => {
          :migration_name => "CreateTrivias"
        }, :migration_file_name => "create_trivias"        
      end
      
      path = File.join('app/views/trivias/show.html.erb')
      m.template 'view.html.erb', path
    end
  end
end
