require 'rails_generator'

module ActsAsTriviaAddedContent

  def route_trivia_answers_as_nested_resource
    sentinel = "ActionController::Routing::Routes.draw do |map|"
    unless options[:pretend]
      gsub_file "config/routes.rb", /(#{Regexp.escape(sentinel)})/mi do |match|
<<-EOS
#{match}
  map.resources :users do |users|
    users.resources :trivias do |trivias|
      trivias.resources :trivia_answers
    end
  end
  
EOS
      end
    end
    
  end
  
  def model_acts_as_trivia_includes(questions)
    acts_as_trivia_calls = questions.map do |question|
      "acts_as_trivia :#{question}"
    end
    logger.modify acts_as_trivia_calls.join(", ")

    sentinel = "class #{class_name} < ActiveRecord::Base"
    unless options[:pretend]
      gsub_file File.join("app/models", class_path, "#{singular_name}.rb"), /(#{Regexp.escape(sentinel)})/mi do |match|
<<-EOS
#{match}
  #{acts_as_trivia_calls.join("\n")}
EOS
      end
    end
  end

end

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
      # m.class_collisions "Trivia", "TriviaAnswer"
      m.class_collisions "TriviasController", "TriviaAnswersController"
      m.class_collisions "TriviaTest"

      # Controller directories.
      m.directory 'app/views/trivias'
      m.directory 'app/views/trivia_answers'

      # Controllers
      m.template 'controller.rb', 'app/controllers/trivias_controller.rb'
      m.template 'answers_controller.rb', 'app/controllers/trivia_answers_controller.rb'
      
      m.route_resources "trivias"
      m.route_trivia_answers_as_nested_resource

      m.model_acts_as_trivia_includes actions

      unless options[:skip_migration]
        m.migration_template 'trivias_migration.rb', 'db/migrate', :assigns => {
          :migration_name => "CreateTrivias",
          :trivia_on => singular_name,
          :trivia_about => actions.first,
          :trivia_displayed => actions.last,
        }, :migration_file_name => "create_trivias"
      end

      path = File.join('app/views/trivias/show.html.erb')
      m.template 'view.html.erb', path
    end
  end
end

Rails::Generator::Commands::Base.send(:include, ActsAsTriviaAddedContent)