module Panini

  class Nonterminal

    attr_reader :name

    def initialize(name=nil)
      @productions = []
      @name = name
    end

    def add_production(production)
      raise ArgumentError, "The production must be an Array." unless production.class == Array
      @productions << production.dup
      nil
    end
    
    def productions
      @productions.dup
    end

    def to_s
      name.nil? ? super : @name
    end

  end

end