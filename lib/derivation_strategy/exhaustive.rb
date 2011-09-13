class Array

  def top
    self.last
  end

  def has_nonterminals?
    self.any? do |term|
      term.class == Panini::Nonterminal
    end
  end

end


module Panini
  module DerivationStrategy

    class Exhaustive < Base

      def initialize(grammar)
        super(grammar)
        @in_progress_work = [].push([@grammar.start])
      end

      # Generates a sentence. 
      def sentence
        unless @in_progress_work.empty?
          while @in_progress_work.top.has_nonterminals?
            generate_work(@in_progress_work.pop)
          end
          @in_progress_work.pop
        end
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
          @in_progress_work.push(newly_derived_sentence)
        end

      end
      private :generate_work

      # 
      # def substitution_pass(derived_sentence)
      #   substituted = false
      #   derived_sentence = derived_sentence.flat_map do |term|
      #     if !substituted && (term.class == Nonterminal)
      #       substituted = true
      #       @production_proxies[term].production
      #     else
      #       term
      #     end
      #   end
      #   return derived_sentence, substituted
      # end
      # private :substitution_pass

    end

  end
end
