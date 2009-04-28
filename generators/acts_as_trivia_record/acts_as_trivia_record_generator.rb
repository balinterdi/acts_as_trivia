class ActsAsTriviaRecordGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      m.migration_template 'migration.rb', 'db/migrate', :assigns => {
        :migration_name => "CreateTriviaFor#{plural_name.capitalize}#{actions.first.capitalize}",
        :trivia_on => singular_name,
        :trivia_about => actions.first,
        :trivia_displayed => actions.last        
      }, :migration_file_name => "create_trivia_for_#{plural_name}_#{actions.first}"
    end
  end
end