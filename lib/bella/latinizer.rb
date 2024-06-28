# frozen_string_literal: true

module Bella
  # Latinizer is a module that provides methods for converting cyrillic text to latin.
  #
  class Latinizer
    VOWELS = %w[а е ё і у ы э ю я].freeze
    POTENTIALLY_SOFT_CONSONANTS = {
      "н" => %w[n ń],
      "с" => %w[s ś],
      "ц" => %w[c ć],
      "з" => %w[z ź]
    }.freeze
    CONVERSION_RULES = {
      "а" => "a", "э" => "e", "ы" => "y", "у" => "u", "ў" => "ŭ",
      "б" => "b", "в" => "v", "г" => "h", "ґ" => "g", "д" => "d",
      "ж" => "ž", "й" => "j", "к" => "k", "м" => "m", "о" => "o",
      "п" => "p", "р" => "r", "т" => "t", "ф" => "f", "ч" => "č",
      "ш" => "š", "х" => "ch"
    }.freeze
    J_CONVERSION_RULES = {
      "е" => "e", "ё" => "o", "і" => "", "ю" => "u", "я" => "a"
    }.freeze
    NON_ALPHA_OR_SPECIAL = /[^[:alpha:]]|[ьъ']/

    class << self
      def latinize(text)
        text.each_char.with_index.map do |char, index|
          convert_char(char, text, index)
        end.join
      end

      private

      def convert_char(char, text, index)
        lowercase_char = char.downcase
        converted = case lowercase_char
                    when *CONVERSION_RULES.keys then CONVERSION_RULES[lowercase_char]
                    when "л" then convert_l(text, index)
                    when *POTENTIALLY_SOFT_CONSONANTS.keys then convert_potentially_soft(lowercase_char, text, index)
                    when *J_CONVERSION_RULES.keys then convert_with_j(char, text, index)
                    when "ь", "'" then ""
                    else char
                    end

        char == char.upcase ? converted.capitalize : converted
      end

      def convert_l(text, index)
        next_char = text[index + 1]&.downcase
        next_char && (%w[ь л] + J_CONVERSION_RULES.keys).include?(next_char) ? "l" : "ł"
      end

      def convert_potentially_soft(char, text, index)
        hard, soft = POTENTIALLY_SOFT_CONSONANTS[char]
        text[index + 1]&.downcase == "ь" ? soft : hard
      end

      def convert_with_j(char, text, index)
        previous_char = text[index - 1]&.downcase
        base = determine_base(char, previous_char)
        second_letter = J_CONVERSION_RULES[char.downcase]
        base + second_letter
      end

      def determine_base(char, previous_char)
        return "" if previous_char == "л" && char.downcase != "і"
        return "i" if previous_char && !VOWELS.include?(previous_char) && !NON_ALPHA_OR_SPECIAL.match?(previous_char)

        char.downcase == "і" ? "i" : "j"
      end
    end
  end
end
