require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    @view = ''
    letters = params[:letters].split(' ')
    word = params[:word]
    if english(word) == true && letters_in_grid(word, letters) == true
      @view = 'Great'
    elsif letters_in_grid(word, letters) == false
      @view = 'Letters not provided'
    else
      @view = 'Not an English word'
    end
  end
end

def english(word)
  url = "https://wagon-dictionary.herokuapp.com/#{word}"
  hash = JSON.parse(URI.open(url).read)
  hash['found']
end

def letters_in_grid(word, letters)
  letter_array = word.upcase.chars
  letter_array.all? { |letter| letter_array.count(letter) <= letters.count(letter) }
end
