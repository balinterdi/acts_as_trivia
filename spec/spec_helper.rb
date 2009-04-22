require 'rubygems'
require "active_record"

# setting up test environment is snatched from how Paperclip does it
ROOT = File.join(File.dirname(__FILE__), '..')
$LOAD_PATH << File.join(ROOT, 'lib')
$LOAD_PATH << File.join(ROOT, 'lib', 'acts_as_trivia')

require File.join(ROOT, "lib", "acts_as_trivia.rb")

ENV['RAILS_ENV'] ||= 'test'

config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
ActiveRecord::Base.establish_connection(config['test'])

def rebuild_trivias_table
  ActiveRecord::Base.connection.create_table :trivias, :force => true do |table|
    table.column :on, :string
    table.column :about, :string
  end
end

def rebuild_countries_table
  ActiveRecord::Base.connection.create_table :countries, :force => true do |table|
    table.column :hdi, :float
    table.column :population, :integer
    table.column :area, :integer
  end
end
