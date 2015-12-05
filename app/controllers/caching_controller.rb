class CachingController < ApplicationController
  VALUES = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0,
            1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0,
            2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.8, 2.9,
            -0.1, -0.2, -0.3, -0.4, -0.5, -0.6, -0.7, -0.8, -0.9, -1.0,
            -1.1, -1.2, -1.3, -1.4, -1.5, -1.6, -1.7, -1.8, -1.9, -2.0,
            -2.1, -2.2, -2.3, -2.4, -2.5, -2.6, -2.7, -2.8, -2.9]

  def index
    @values = VALUES.map { |x| sin(x) }
  end

  private

  def factorial(n)
    Rails.cache.fetch("factorial?#{n}") do
      return 1 if n == 1
      n * factorial(n - 1)
    end
  end

  def sin(x)
    # Maclaurin series expansion of sin(x) http://en.wikipedia.org/wiki/Taylor_series
    Rails.cache.fetch("sin?#{x}") do
      total_num_terms = 10
      (0..total_num_terms).reduce(0) do |term_sum, term_num|
        term_sum + sine_term(x, term_num)
      end
    end
  end

  # Value for a given term in a sine expansion for x
  def sine_term(x, term_num)
    n = 1 + (term_num * 2)
    term = x**n / factorial(n)
    term * term_sign(term_num)
  end

  # Alternate term signs
  def term_sign(term_num)
    term_num.even? ? 1 : -1
  end

  add_method_tracer :sin, 'Custom/compute_sine'
end
