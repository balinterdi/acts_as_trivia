class Trivia < ActionRecord::Base
  def to_param
    "#{on}-#{about}" # e.g country-hdi
  end
end