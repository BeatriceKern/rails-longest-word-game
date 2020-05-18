require 'open-uri'

class GamesController < ApplicationController

  def new
    charset = Array('A'..'Z')
    @letters = Array.new(10){charset.sample}
  end

  def score
    if letters_included? == false
        "Sorry the word #{params[:word]} cannot be built out of #{params[:letters]}."
    elsif english_word? == false
        "Sorry the word #{params[:word]} is not part of the english dictionary."
    else
        "Congratulations! #{params[:word]} is a valid english word!"
    end
    return @result
  end

  def letters_included?
    true_score = params[:word].upcase.chars.all? {|char| params[:letters].include?char }
  end

  def english_word?
    check = open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read
    word_check = JSON.parse(check)
    word_check.include? params[:word]
  end
end
