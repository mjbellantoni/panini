class Array

  def top
    self.last
  end

  def has_nonterminals?
    self.any? do |term|
      term.class == Panini::Nonterminal
    end
  end

  def fully_derived?
    not has_nonterminals?
  end

end


module Panini
  module DerivationStrategy

    class Exhaustive < Base

      def initialize(grammar, length_limit = nil)
        super(grammar)
        @in_progress_work = [].push([@grammar.start])
        @length_limit = length_limit
      end

      # Generates a sentence. 
      def sentence
        # unless @in_progress_work.empty?
        while !@in_progress_work.empty? && @in_progress_work.top.has_nonterminals?
          generate_work(@in_progress_work.pop)
        end
        @in_progress_work.pop
        # end
      end

      def generate_work(derived_sentence)

        # Find the leftmost nonterminal.
        i = derived_sentence.index do |term|
          term.class == Nonterminal
        end
        nonterminal = derived_sentence[i]

        # Substitute in each production for the nonterminal.  Do it
        # in reverse because it causes the results to happen in a more
        # intuitive order.
        nonterminal.productions.reverse.each do |production|
          j = 0
          newly_derived_sentence = derived_sentence.flat_map do |term|
            if (i == j)
              j += 1
              production
            else
              j += 1
              term
            end
          end

          # If we're limiting lengths see if completed derivations should
          # be discarded.
          unless (limiting_lengths? && newly_derived_sentence.fully_derived? && newly_derived_sentence.size > @length_limit)
            @in_progress_work.push(newly_derived_sentence)
          end

        end

      end
      private :generate_work

      def limiting_lengths?
        not @length_limit.nil?
      end
      private :limiting_lengths?

    end

  end
end
