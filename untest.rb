#!/usr/bin/env ruby

require 'pry'

# Unfair Test

class Test
  #CORRECT_POINTS = 15

  def initialize
    @arQuest = ["What is 3+5?","What colour is a Banana?","How many colours are there on a Rubix cube?"]
    @arAnswer = ["8","Yellow","6"]

    @total = []
  end

  def run
    @arQuest.each_with_index do |qs, index|
      @thQuest = Thread.new{question(index)}
      @thTimer = Thread.new{timer}
      @thQuest.join
      @thTimer.join
    end
    puts ''
    puts "#########################################"
    puts "End of Test"
    puts "Your total score is #{@total.inject(:+)}"
    puts "#########################################"
  end

  def question(question_number)
    puts @arQuest[question_number]
    puts ''
    @answer = gets.chomp

    is_answer_correct?(question_number)
  end

  def timer
    @score = 120

    12.times do
      @score -= 10
      next if @score == 0
      sleep 0.5
    end

    @thQuest.kill
    puts 'Time has run out'
  end

  def is_answer_correct?(question_number)
    if @answer.downcase == @arAnswer[question_number].downcase
      puts ''
      puts 'Correct!'
      puts ''
      @thTimer.kill
      @total << @score
    else
      puts ''
      puts 'Incorrect!'
      puts ''
      @thTimer.kill
    end
  end
end

Test.new.run
