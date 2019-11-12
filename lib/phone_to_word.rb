# frozen_string_literal: true

require 'json'

# Exceptions related to phone number
class InvalidPhoneError < StandardError; end

# class responsible to find probable word for any phone number
class PhoneToWord
  attr_reader :phone_number

  DICTIONARY_FILE_PATH = 'public/dictionary.txt'
  DICTIONARY_JSON_FILE_PATH = 'public/dictionary.json'
  MAX_PHONE_NUMBER_LENGTH = 10
  MIN_WORD_LENGTH = 3
  MAX_WORD_COMBINATION = 3

  def initialize(phone_number = nil)
    @phone_number = phone_number.to_s

    @words_list_hash = Hash.new { |h, k| h[k] = [] }

    # save words with it's assicated number in a json file
    if !File.file?(DICTIONARY_JSON_FILE_PATH)
      File.read(DICTIONARY_FILE_PATH).split("\n").each do |word|
        word_length = word.length
        if word_length > MAX_PHONE_NUMBER_LENGTH || word_length < MIN_WORD_LENGTH
          next
        end

        word = word.downcase
        number = get_number_of_word(word)
        @words_list_hash[number] << word
      end
      File.open(DICTIONARY_JSON_FILE_PATH, 'w') { |file| file.write(@words_list_hash.to_json) }
    else
      @words_list_hash = JSON.parse(File.read(DICTIONARY_JSON_FILE_PATH))
    end

    # Ask user for input
    if @phone_number.empty?
      puts 'Please enter 10 digit phone number:'
      @phone_number = STDIN.gets.chomp
    end

    # Raise custom exception on invalid phone number
    raise InvalidPhoneError unless valid_phone_number?
  rescue InvalidPhoneError
    puts 'Please enter 10 digit phone number without any 0s and 1s.'
  end

  # will return false if phone number invalid
  # number max length is MAX_PHONE_NUMBER_LENGTH = 10
  # number should not contain 0s and 1s
  def valid_phone_number?
    !@phone_number.empty? && @phone_number.length == MAX_PHONE_NUMBER_LENGTH &&
      @phone_number.match(/^[2-9]*$/)
  end

  # Get associated number for the word
  def get_number_of_word(word)
    number_for_word = ''
    word.split('').each do |a_letter|
      case a_letter
      when 'a', 'b', 'c' then      number_for_word += '2'
      when 'd', 'e', 'f' then      number_for_word += '3'
      when 'g', 'h', 'i' then      number_for_word += '4'
      when 'j', 'k', 'l' then      number_for_word += '5'
      when 'm', 'n', 'o' then      number_for_word += '6'
      when 'p', 'q', 'r', 's' then number_for_word += '7'
      when 't', 'u', 'v' then      number_for_word += '8'
      when 'w', 'x', 'y', 'z' then number_for_word += '9'
      end
    end
    number_for_word
  end

  # 10, 5 x 5
  # 4 x 6, 6 x 4
  # 3 x 3 x 4,
  # 3 x 4 x 3,
  # 4 x 3 x 3
  # 3 x 7, 7 x 3
  def possible_combinations
    with_3_digit = @phone_number[0..2]
    with_4_digit = @phone_number[0..3]
    with_6_digit = @phone_number[6..9]
    with_7_digit = @phone_number[7..9]
    [
      [@phone_number],
      [@phone_number[0..4], @phone_number[5..9]],
      [with_4_digit, @phone_number[4..9]],
      [@phone_number[0..5], with_6_digit],
      [with_3_digit, @phone_number[3..5], with_6_digit],
      [with_3_digit, @phone_number[3..6], with_7_digit],
      [with_4_digit, @phone_number[4..6], with_7_digit],
      [with_3_digit, @phone_number[3..9]],
      [@phone_number[0..6], with_7_digit]
    ]
  end

  # all combinations of words for the phone number
  def possilbe_words_combinations
    all_words_combinations = []
    possible_combinations.each do |a_combination|
      words_for_a_combination = []
      a_combination.each do |a_number|
        word = @words_list_hash[a_number]
        words_for_a_combination << word if word && !word.empty?
      end
      if a_combination.size == words_for_a_combination.size
        all_words_combinations << words_for_a_combination
      end
    end

    all_words = []
    all_words_combinations.each do |one_combination|
      next if one_combination.size > MAX_WORD_COMBINATION

      final_combination, *sub_combination = one_combination
      all_words += final_combination.product(*sub_combination)
    end
    all_words
  end
end
