

class Fixnum

HASH = {
  0 => 'zero',
  1 => 'one',
  2 => 'two',
  3 => 'three',
  4 => 'four',
  5 => 'five',
  6 => 'six',
  7 => 'seven',
  8 => 'eight',
  9 => 'nine',
  10 => 'ten',
  11 => 'eleven',
  12 => 'twelve',
  13 => 'thirteen',
  14 => 'fourteen',
  15 => 'fifteen',
  16 => 'sixteen',
  17 => 'seventeen',
  18 => 'eighteen',
  19 => 'nineteen',
  20 => 'twenty',
  30 => 'thirty',
  40 => 'forty',
  50 => 'fifty',
  60 => 'sixty',
  70 => 'seventy',
  80 => 'eighty',
  90 => 'ninety',
  '10^3' => 'thousand',
  '10^6' => 'million',
  '10^9' => 'billion',
  '10^12' => 'trillion'
}

  def in_words
    if self < 0
      return "negative " + (self * -1).in_words
    end

    if self > 1_000_000_000_000_000
      return "Really big, those are the words."
    end

    if self < 100
      if self < 21
        return HASH[self]
      end

      last_digit = self % 10
      remainder = self - last_digit
      return HASH[remainder] + remainder_in_words(last_digit)
    end

    if self < 1000
      hundreds_digit = self/100
      remainder = self % 100
      return HASH[hundreds_digit] + " hundred" + remainder_in_words(remainder)
    end

    # if self < 1_000_000
    #   remainder = self % 1_000
    #   thousands = self / 1_000
    #   return thousands.in_words + " thousand" + remainder_in_words(remainder)
    # end

    power = 3
    while (10 ** (power + 3)) <= self
      power += 3
    end
    place = (10 ** power)
    illions = self / place
    remainder = self - (illions * place)
    return illions.in_words + " " + HASH["10^#{power}"] + remainder_in_words(remainder)
  end

  def remainder_in_words(remainder)
    if remainder == 0
      return ""
    else
      return " " + remainder.in_words
    end
  end

end
