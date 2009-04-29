require "rubygems"
require "spec"
require "mocha"

require File.join(File.dirname(__FILE__), 'spec_helper')

# use mocha for mocking instead of
# Rspec's own mock framework
Spec::Runner.configure do |config|
  config.mock_with :mocha
end

class Country < ActiveRecord::Base
  include ActsAsTrivia
end

describe "A Trivia" do
  before do
    rebuild_trivias_table
    rebuild_countries_table
    @trivia = Trivia.create(:on => "country", :about => "hdi", :displayed => "name", :length => 3)
    Country.class_eval do
      acts_as_trivia :hdi
    end
    @iceland = Country.create(:hdi => 0.968, :name => "Iceland")
    @canada = Country.create(:hdi => 0.967, :name => "Canada")
    @new_zealand = Country.create(:hdi => 0.944, :name => "New Zealand")
    @cyprus = Country.create(:hdi => 0.903, :name => "Cyprus")
  end

  describe "when assessing the answer" do
    before do

    end

  end

  describe "when assessing" do
    before do
      Country.expects(:find).returns([@iceland, @canada, @new_zealand])
    end

    it "should give top score for the correct one" do
      score = @trivia.assess_answer([@iceland, @canada, @new_zealand])
      score.should equal(3)
    end

    it "should give a point for each correct position" do
      score = @trivia.assess_answer([@canada, @iceland, @new_zealand])
      score.should equal(1)
    end

    it "should return zero if none of the positions is asserted" do
      score = @trivia.assess_answer([@canada, @new_zealand, @iceland])
      score.should equal(0)
    end
  end

  it "should get the trivia subjects of the right class" do
    Country.expects(:find).with(:all).returns([@iceland, @canada, @new_zealand])
    @trivia.get_subjects
  end

  describe "fetching the solution" do
    before do
      @solution = @trivia.get_solution_values
    end
    it "should have the length of the trivia" do
      @solution.should have(3).items
    end
    it "should fetch the correct one" do
      @solution.should eql([["Iceland", 0.968], ["Canada", 0.967], ["New Zealand", 0.944]])
    end
  end

end

describe "An acts_as_trivia enabled model class" do
  before do
    rebuild_countries_table
    Country.class_eval do
      acts_as_trivia :hdi
    end
    @iceland = Country.create(:hdi => 0.968)
    @canada = Country.create(:hdi => 0.967)
    @new_zealand = Country.create(:hdi => 0.944)
  end

  it "should respond to the generated trivia accessor" do
    Country.should respond_to(:trivia_answer_for)
  end
end

describe "a user" do
  before do
    rebuild_all_tables
    class User < ActiveRecord::Base
      has_many :trivia_answers
      has_many :trivias, :through => :trivia_answers
    end
    @user = User.create(:login => "bob")
    @trivia = Trivia.create(:on => "country", :about => "hdi")
  end

  it "should be easily added a trivia he played" do
    @user.add_trivia(@trivia)
    @user.trivias.should include(@trivia)
  end

  it "should return true when asked if played a trivia he played" do
    @user.trivias << @trivia
    @user.played_trivia?(@trivia).should be_true
  end

  it "should return false when asked if played a trivia he did not play" do
    another_trivia = Trivia.create(:on => "country", :about => "population")
    @user.played_trivia?(another_trivia).should be_false
  end

  it "should have 0 trivia points when he has not played any trivia" do
    @user.trivia_answers = []
    @user.trivia_points.should eql(0)
  end

  it "should be able to tell the total trivia points he earned" do
    a_trivia = Trivia.create(:on => "country", :about => "hdi")
    another_trivia = Trivia.create(:on => "country", :about => "population")
    @user.trivia_answers.create(:trivia => a_trivia, :points => 2)
    @user.trivia_answers.create(:trivia => another_trivia, :points => 3)
    @user.trivia_points.should eql(5)
  end

end

