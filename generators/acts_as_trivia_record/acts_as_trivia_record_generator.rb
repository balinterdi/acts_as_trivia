require 'rails_generator'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'acts_as_trivia_commands'))

class ActsAsTriviaRecordGenerator < Rails::Generator::NamedBase
  
  def manifest
    record do |m|
      trivia_about = actions.first
      m.model_acts_as_trivia_includes trivia_about
      
      m.migration_template 'migration.rb', 'db/migrate', :assigns => {
        :migration_name => "CreateTriviaFor#{plural_name.capitalize}#{actions.first.capitalize}",
        :trivia_on => singular_name,
        :trivia_about => actions.first,
        :trivia_displayed => actions.last        
      }, :migration_file_name => "create_trivia_for_#{plural_name}_#{actions.first}"
    end
  end
end

Rails::Generator::Commands::Base.send(:include, ActsAsTriviaCommands)