module Panini
  module DerivationStrategy

    class RoundRobinProductionChoiceProxy

      def initialize(nonterminal)
        @nonterminal = nonterminal
        @round_robin_count = 0
        @production_count = @nonterminal.productions.count
      end

      def production
        i = @round_robin_count % @production_count
        @round_robin_count += 1
        @nonterminal.productions[i]
      end

    end

    # The Leftmost strategy is a naive strategy for deriving sentences from a grammar.  It
    # will aways substitute for the leftmost nonterminal first.  If a nonterminal has more
    # than one production, they will be chosen in a round-robin ordering.
    #
    # This implementation is slow and will not work on many grammars.
    #
    # In other words, don't use this! It's  in place because it is simple to and was used
    # for early testing.
    class Leftmost < Base

      def initialize(grammar)
        build_production_proxies(grammar)
        super(grammar)
      end

      def build_production_proxies(grammar)
        @production_proxies = {}
        grammar.nonterminals.each do |nonterminal|
          @production_proxies[nonterminal] = RoundRobinProductionChoiceProxy.new(nonterminal)
        end
      end
      private :build_production_proxies

      # Generates a sentence. 
      def sentence
        derived_sentence, substituted = [@grammar.start], false
        begin
          derived_sentence, substituted = substitution_pass(derived_sentence)
        end while substituted
        derived_sentence
      end

      def substitution_pass(derived_sentence)
        substituted = false
        derived_sentence = derived_sentence.flat_map do |term|
          if !substituted && (term.class == Nonterminal)
            substituted = true
            @production_proxies[term].production
          else
            term
          end
        end
        return derived_sentence, substituted
      end
      private :substitution_pass

    end

  end
end
