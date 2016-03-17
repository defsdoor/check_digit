module CheckDigit::Luhn
  def self.checksum(num)
    CheckDigit::Util.valid_arg(num)
    calc(num)
  end
  
  def self.valid?(num)
    self.calc(num.div(10)) == num
  end

  private
  
  def self.calc(num)
    i=false
    tot=0
    tmp = num * 10
    while tmp > 0 do
      tmp, digit = tmp.divmod(10)
      unless i=!i
        digit *= 2
        digit -= 9 if digit > 9
      end
      tot += digit
    end
    tot = tot.modulo(10)

    num * 10 + (tot ==0 ? 0 : 10-tot)
  end

end
