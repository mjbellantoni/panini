module Panini


  # The Grammar stores the start symbol and nonterminals.
  class Grammar
    
    def initialize
      @nonterminals = []
    end

    # Returns the grammar's start symbol. This will always be the first
    # nonterminal added to the grammar.
    def start
      @nonterminals[0]
    end

    # Add a nonterminal to the grammar.
    def add_nonterminal(name = nil)
      Panini::Nonterminal.new(name).tap do |new_nonterminal|
        @nonterminals << new_nonterminal
      end
    end

    # The list of nonterminals in the grammar.
    def nonterminals
      @nonterminals.dup
    end
    
  end

end