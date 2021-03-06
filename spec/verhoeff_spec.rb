require 'spec_helper'

module CheckDigit
  describe Verhoeff do
    it "generates checksum values" do
      val = (1..23).inject(1) { |val, i| Verhoeff.checksum val }
      expect(val).to eq(150493068613366131371194)

      expect(Verhoeff.checksum(100913449)).to eq(1009134492)
      expect(Verhoeff.checksum(123)).to eq(1233)
    end

    it "generates a checkum value for an integer string" do
      expect(Verhoeff.checksum("123")).to eq(1233)
    end

    it "raises an error for a non-integer string" do
      expect {Verhoeff.checksum("A123")}.
        to raise_error(ArgumentError, 'invalid argument')

      expect {Verhoeff.valid?("A123")}.
        to raise_error(ArgumentError, 'invalid argument')
    end

    it "raises an error for a non-integer numeric" do
      expect {Verhoeff.checksum("123.45")}.
        to raise_error(ArgumentError, 'invalid argument')

      expect {Verhoeff.valid?("123.45")}.
        to raise_error(ArgumentError, 'invalid argument')
    end

    it "tests an existing number for a valid checksum" do
      expect(Verhoeff.valid?(9998)).to be true
      expect(Verhoeff.valid?(9999)).to be false
    end

    it "benchmarks performance (#{BMITERS} iterations)" do
      puts '  ' + '-' * 55
      Benchmark.bm(10) do |x|
        x.report("  generate:") {
          i = BMITERS
          while i > 1
            Verhoeff.checksum(i)
            i-=1
          end
        }

        x.report("  validate:") {
          i = BMITERS
          while i > 1
            Verhoeff.valid?(i)
            i-=1
          end
        }
      end
      puts '  ' + '-' * 55
    end
  end
end
