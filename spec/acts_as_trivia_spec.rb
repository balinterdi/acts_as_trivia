require "rubygems"
require "spec"
require "mocha"

require File.join(File.dirname(__FILE__), 'spec_helper')

# use mocha for mocking instead of
# Rspec's own mock framework
Spec::Runner.configure do |config|
  config.mock_with :mocha
end

describe "An acts_as_trivia enabled model class" do
  before do
    class Country
      include ActsAsTrivia
      
      attr_accessor :hdi
      def initialize(hdi)
        @hdi = hdi
      end      
      acts_as_trivia :hdi
    end
    @iceland = Country.new(0.968)
    @canada = Country.new(0.967)
    @new_zealand = Country.new(0.944)
  end
  
  it "should respond to the generated trivia accessor" do
    Country.should respond_to(:trivia_answer_for)
  end
  
  it "should use the find method of the model class" do
    Country.expects(:find).returns([@iceland, @canada, @new_zealand])
    countries_by_hdi = Country.trivia_answer_for(:hdi)
  end
  
  describe "when assessing the answer" do
    before do
      Country.expects(:find).returns([@iceland, @canada, @new_zealand])
    end
    
    it "should give top score for the correct one" do
      score = Country.assess_trivia(:hdi, [@iceland, @canada, @new_zealand])
      score.should equal(3)
    end
  
    it "should give a point for each correct position" do
      score = Country.assess_trivia(:hdi, [@canada, @iceland, @new_zealand])
      score.should equal(1)
    end

    it "should return zero if none of the positions is asserted" do
      score = Country.assess_trivia(:hdi, [@canada, @new_zealand, @iceland])
      score.should equal(0)
    end
  end
end
