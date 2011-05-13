module Panini

  class Grammar
    
    def initialize
      @nonterminals = []
    end

    def start
      @nonterminals[0]
    end

    def add_nonterminal
      Panini::Nonterminal.new.tap do |new_nonterminal|
        @nonterminals << new_nonterminal
      end
    end

    def nonterminals
      @nonterminals.dup
    end
    
  end

end