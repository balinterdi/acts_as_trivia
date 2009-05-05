require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('acts_as_trivia', '0.1.1') do |p|
  p.description    = <<-EOS
    This gem will add the possibility to turn your Rails application into a trivia game with the ease of generating a migration. The only thing you need is a model class with a sortable attribute and this gem.
  EOS
  p.url            = "http://github.com/balinterdi/acts_as_trivia"
  p.author         = "Balint Erdi"
  p.email          = "balint.erdi@gmail.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
