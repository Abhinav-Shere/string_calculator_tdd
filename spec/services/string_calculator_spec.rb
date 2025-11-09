require 'rails_helper'

RSpec.describe StringCalculator, type: :service do
  describe '.add' do
    it 'returns 0 for an empty string' do
      expect(StringCalculator.add("")).to eq(0)
    end

    it 'returns the number itself for a single number' do
      expect(StringCalculator.add("1")).to eq(1)
    end

    it 'returns the sum of two numbers separated by a comma' do
      expect(StringCalculator.add("1,5")).to eq(6)
    end

    it 'returns the sum of numbers separated by newline and comma' do
      expect(StringCalculator.add("1\n2,3")).to eq(6)
    end

    it 'supports custom delimiters' do
      expect(StringCalculator.add("//;\n1;2")).to eq(3)
    end

    it 'supports multiple delimiters with custom length' do
      expect(StringCalculator.add("//[*][%]\n1*2%3")).to eq(6)
    end

    it 'supports multi-character custom delimiters' do
      expect(StringCalculator.add("//[***]\n1***2***3")).to eq(6)
    end

    it 'ignores numbers greater than 1000' do
      expect(StringCalculator.add("2,1001")).to eq(2)
    end

    it 'raises an error for negative numbers' do
      expect { StringCalculator.add("1,-2,-3") }.to raise_error("negative numbers not allowed: -2, -3")
    end

    it 'raises an error for a single negative number' do
      expect { StringCalculator.add("-1") }.to raise_error("negative numbers not allowed: -1")
    end

    it 'ignores numbers greater than 1000 and sums the valid numbers' do
      expect(StringCalculator.add("2,1001,1000")).to eq(1002)
    end
  end
end
