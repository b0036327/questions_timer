#!/usr/bin/env ruby

# Unfair Test

class Test
  def initialize
    @questions = ['What is 3+5?', 'What colour is a Banana?', 'How many colours are there on a Rubix cube?']
    @answers = ['8', 'Yellow', '6']

    @total = []
  end

  def run
    @questions.each_with_index do |_question, index|
      @question_timer = Thread.new { question(index) }
      @timer = Thread.new { timer }
      @question_timer.join
      @timer.join
    end

    end_of_test
  end

  def question(question_number)
    puts @questions[question_number]
    puts ''
    @answer = gets.chomp

    answer_correct?(question_number)
  end

  def timer
    @score = 120

    12.times do
      @score -= 10
      next if @score == 0
      sleep 0.5
    end

    @question_timer.kill
    puts 'Time has run out'
  end

  def answer_correct?(question_number)
    if @answer.downcase == @answers[question_number].downcase
      add_space
      puts 'Correct!'
      add_space
      @timer.kill
      @total << @score
    else
      add_space
      puts 'Incorrect!'
      add_space
      @timer.kill
    end
  end

  def end_of_test
    add_space
    puts '#########################################'
    puts 'End of Test'
    puts "Your total score is #{@total.inject(:+)}"
    puts '#########################################'
  end

  def add_space
    puts ''
  end
end

Test.new.run
