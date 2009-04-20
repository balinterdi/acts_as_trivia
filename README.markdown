* NoMethodError (undefined method `acts\_as\_trivia' for #<Class:0x253e9fc>):

  Make sure you have the config.gem "acts\_as\_trivia" line in your environment.rb

* a complete controller action would look like this:
  
  class CountryTriviaController < ApplicationController
    def hdi
      @countries = Country.all
      if request.post?
        countries = Country.find(params[:country][:hdi])
        score = Country.assess_trivia(:hdi, countries)
        flash[:ok] = "You got #{score} right"
        redirect_to country_hdi_trivia_path
      end
    end

  end
  