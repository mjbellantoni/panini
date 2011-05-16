module Panini

  class Nonterminal

    attr_reader :name

    # Initialize a nonterminal. Optionally specify a name.
    def initialize(name=nil)
      @productions = []
      @name = name
    end

    # Add a production to the nonterminal.  It must be an array, but the array can
    # contain any type of Ruby object.
    #
    #  nonterminal.add_production([1, 'a', lambda { ...} ])
    #
    def add_production(production)
      raise ArgumentError, "The production must be an Array." unless production.class == Array
      @productions << production.dup
      nil
    end

    # The productions for the nonterminal.
    def productions
      @productions.dup
    end

    def to_s
      name.nil? ? super : @name
    end

  end

end