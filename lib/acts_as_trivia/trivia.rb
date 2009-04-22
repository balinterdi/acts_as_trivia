class Trivia < ActiveRecord::Base
  def to_param
    "#{on}-#{about}"
  end
end
