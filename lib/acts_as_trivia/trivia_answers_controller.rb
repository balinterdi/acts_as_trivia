require File.expand_path(File.join((File.dirname(__FILE__)), 'trivias_helper'))

TriviaAnswersController.send(:helper, TriviasHelper)
# class TriviaAnswersController < ApplicationController
#   helper TriviasHelper
# end