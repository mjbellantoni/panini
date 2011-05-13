module Panini
  module DerivationStrategy

    class Rightmost < DerivationStrategy::Base

      def sentence
        @grammar.start.productions[0]
      end

    end

  end
end