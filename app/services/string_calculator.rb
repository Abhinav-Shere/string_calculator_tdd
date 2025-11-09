class StringCalculator
  def self.add(numbers)
    return 0 if numbers.empty?

    negatives = []
    sum = 0
    delimiters = [',']

    if numbers.start_with?("//")
      delimiter_section, numbers = numbers.split("\n", 2)
      delimiters = extract_delimiters(delimiter_section)
    end

    numbers.split(/[\n#{delimiters.join}]/).each do |num|
      number = num.to_i

      if number < 0
        negatives << number
      elsif number <= 1000
        sum += number
      end
    end

    if negatives.any?
      raise "negative numbers not allowed: #{negatives.join(', ')}"
    end

    sum
  end

  private
  def self.extract_delimiters(delimiter_section)
    if delimiter_section.start_with?("//[")
      delimiter_section[3..-2].split('][')
    else
      [delimiter_section[2]]
    end
  end
end
