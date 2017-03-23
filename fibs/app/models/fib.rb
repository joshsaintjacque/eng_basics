class Fib < ApplicationRecord
  validates_presence_of :name, :sequence_length
  serialize :generated_fibs

  before_save { generate sequence_length }

  # Returns an Array of Integer objects containing the first x numbers of the
  # Fibonacci sequence
  #
  # Input:
  #
  #   +x+ - Required. A non-negative Integer defining the upper limit of the
  #         sequence to be generated.
  #
  # Example:
  #
  #   fib = Fib.new
  #   fib.generate 10
  #   #=>  [ 0, 1, 1, 2, 3, 5, 8, 13, 21, 34 ]
  #
  # The generated values are stored in the following instance variable:
  # +@generated_fibs+
  def generate x
    unless x.is_a?(Integer) && x >= 0
      raise ArgumentError, "Expected non-negative integer, received #{x}"
    end
    return self.generated_fibs if self.generated_fibs.to_a.length >= x
    self.generated_fibs = generate_fibs x
    save
    return self.generated_fibs
  end

  # Returns a Boolean indicating whether the passed value is known to be a
  # Fibonacci number.
  #
  # Input:
  #
  #   +num+ - Required. The number to compare to known Fibonacci numbers stored
  #           in +@generated_fibs+.
  #
  # Example:
  #
  #   fib.is_known_fib? 3
  #   #=>  true
  def is_known_fib? num
    generated_fibs.include? num
  end

  # Returns a Boolean indicating whether all values in the passed array are in
  # the known Fibonacci sequence. If the sequence includes values larger than
  # what's known, additional Fibonacci numbers will be generated until are
  # values in the array are covered.
  #
  # Input:
  #
  #   +seq_array+ - Required. An Array of values to compare.
  #
  # Example:
  #
  #   fib.all_fibs? [ 21, 8, 3 ]
  #   #=>  true
  def all_fibs? seq_array
    max_value = seq_array.max
    generate generated_fibs.length + 1 while max_value > generated_fibs.last
    seq_array.all? { |n| is_known_fib? n }
  end

  # Returns an Integer representing the sum of squares of the Fibonacci
  # numbers stored in +@generated_fibs+.
  def known_fibs_sum_of_squares
    generated_fibs.nil? ? 0 : (generated_fibs.map { |n| n ** 2 }.reduce :+)
  end

  private

  def generate_fibs x
    # Approaching iteratively since recursion could crash on very large inputs
    return (0..x).to_a if x < 2
    fibs = generated_fibs || [0, 1]
    previous, current = fibs.last(2).first, fibs.last
    (x - fibs.length).times do
      current, previous = previous + current, current
      fibs << current
    end
    fibs
  end
end
