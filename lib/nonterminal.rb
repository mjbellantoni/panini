module Panini

  class Nonterminal

    def initialize
      @productions = []
    end

    def add_production(production)
      raise ArgumentError, "The production must be an Array." unless production.class == Array
      @productions << production.dup
      nil
    end
    
    def productions
      @productions.dup
    end

  end

end