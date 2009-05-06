# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{acts_as_trivia}
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Balint Erdi"]
  s.date = %q{2009-05-06}
  s.description = %q{This gem will add the possibility to turn your Rails application into a trivia game with the ease of generating a migration. The only thing you need is a model class with a sortable attribute and this gem.}
  s.email = %q{balint.erdi@gmail.com}
  s.extra_rdoc_files = ["CHANGELOG", "lib/acts_as_trivia/trivia.rb", "lib/acts_as_trivia/trivia_answer.rb", "lib/acts_as_trivia/trivia_answers_controller.rb", "lib/acts_as_trivia/trivias_helper.rb", "lib/acts_as_trivia/user.rb", "lib/acts_as_trivia.rb", "LICENSE", "README.markdown", "tasks/acts_as_trivia.rake"]
  s.files = ["acts_as_trivia.gemspec", "CHANGELOG", "generators/acts_as_trivia/acts_as_trivia_generator.rb", "generators/acts_as_trivia/templates/answers_controller.rb", "generators/acts_as_trivia/templates/controller.rb", "generators/acts_as_trivia/templates/trivias_migration.rb", "generators/acts_as_trivia/templates/view.html.erb", "generators/acts_as_trivia/USAGE", "generators/acts_as_trivia_record/acts_as_trivia_record_generator.rb", "generators/acts_as_trivia_record/templates/migration.rb", "generators/acts_as_trivia_record/USAGE", "generators/lib/acts_as_trivia_commands.rb", "lib/acts_as_trivia/trivia.rb", "lib/acts_as_trivia/trivia_answer.rb", "lib/acts_as_trivia/trivia_answers_controller.rb", "lib/acts_as_trivia/trivias_helper.rb", "lib/acts_as_trivia/user.rb", "lib/acts_as_trivia.rb", "LICENSE", "Manifest", "Rakefile", "README.markdown", "spec/acts_as_trivia_spec.rb", "spec/database.yml", "spec/spec_helper.rb", "tasks/acts_as_trivia.rake", "todos.markdown"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/balinterdi/acts_as_trivia}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Acts_as_trivia", "--main", "README.markdown"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{acts_as_trivia}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{This gem will add the possibility to turn your Rails application into a trivia game with the ease of generating a migration. The only thing you need is a model class with a sortable attribute and this gem.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
