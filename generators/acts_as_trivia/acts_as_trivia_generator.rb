require 'rails_generator'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'acts_as_trivia_commands'))

class ActsAsTriviaGenerator < Rails::Generator::Base # ControllerGenerator

  # this is snatched from the resource generator in the Rails source
  default_options :skip_timestamps => false, :skip_migration => false

  def manifest
    record do |m|
      # Check whether the given class names are already taken by
      # Ruby or Rails.  In the future, expand to check other namespaces
      # such as the rest of the user's app.
      # m.class_collisions "Trivia", "TriviaAnswer"
      # m.class_collisions "TriviasController", "TriviaAnswersController"
      m.class_collisions "TriviaTest"

      # Controller directories.
      m.directory 'app/views/trivias'
      m.directory 'app/views/trivia_answers'

      # Controllers
      m.template 'controller.rb', 'app/controllers/trivias_controller.rb'
      m.template 'answers_controller.rb', 'app/controllers/trivia_answers_controller.rb'
      
      m.route_resources "trivias"
      m.route_trivia_answers_as_nested_resource

      unless options[:skip_migration]
        m.migration_template 'trivias_migration.rb', 'db/migrate', :assigns => {
          :migration_name => "CreateTrivias",
        }, :migration_file_name => "create_trivias"
      end

      path = File.join('app/views/trivias/show.html.erb')
      m.template 'view.html.erb', path
    end
  end
end

Rails::Generator::Commands::Base.send(:include, ActsAsTriviaCommands)