# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'PhoneToWord' do
  describe 'initialize' do
    context 'invalid phone number with 0s and 1s' do
      it 'should through InvaliPhoneNumber exception' do
        expect { PhoneToWord.new(1_081_787_825) }.to raise_error(InvalidPhoneError)
      end
    end

    context 'invalid phone number with mismatch length' do
      it 'should through InvaliPhoneNumber exception for number with more than 10 digits' do
        expect { PhoneToWord.new(234_581_787_825) }.to raise_error(InvalidPhoneError)
      end

      it 'should through InvaliPhoneNumber exception for number with less than 10 digits' do
        expect { PhoneToWord.new(81_787_825) }.to raise_error(InvalidPhoneError)
      end
    end

    context 'valid phone number with length 10, no 0s and 1a' do
      it 'should not throw InvaliPhoneNumber exception' do
        expect { PhoneToWord.new(2_345_678_922) }.to_not raise_error
      end
    end
  end

  describe 'all combinations of phone number for valid phone number' do
    it 'should get all possible combinations of the phone number' do
      combinations = PhoneToWord.new(6_686_787_825).possible_combinations
      excepted_array = [%w[668 678 7825], %w[668 6787 825], %w[668 6787825],
                        %w[6686 787 825], %w[6686 787825], %w[66867 87825],
                        %w[668678 7825], %w[6686787 825], ['6686787825']]
      expect(combinations).to match_array(excepted_array)
    end
  end

  describe 'all possible combinations of word for valid phone number' do
    it 'should list all possible words combinations' do
      words_combinations = PhoneToWord.new(6_686_787_825).possilbe_words_combinations
      excepted_array = [['motortruck'], %w[noun struck], %w[onto struck],
                        %w[motor truck], %w[motor usual], %w[nouns truck],
                        %w[nouns usual], %w[mot opt puck], %w[mot opt ruck],
                        %w[mot opt suck], %w[mot opts taj], %w[oot ort puck],
                        %w[oot ort ruck], %w[oot ort suck], %w[oot orts taj],
                        %w[mot opus taj], %w[mot ort puck], %w[mot ort ruck],
                        %w[mot ort suck], %w[oot opt suck], %w[oot opts taj],
                        %w[oot opus taj], %w[mot orts taj], %w[not opt puck],
                        %w[not opt ruck], %w[not opt suck], %w[onto sup taj],
                        %w[onto suq taj], %w[oot opt puck], %w[oot opt ruck],
                        %w[not opts taj], %w[not opus taj], %w[not ort puck],
                        %w[not ort ruck], %w[not ort suck], %w[not orts taj],
                        %w[noun pup taj], %w[noun pur taj], %w[noun suq taj],
                        %w[onto pup taj], %w[onto pur taj], %w[onto pus taj],
                        %w[noun pus taj], %w[noun sup taj]]
      expect(words_combinations).to match_array(excepted_array)
    end
  end
end
