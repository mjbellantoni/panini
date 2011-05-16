require "spec_helper"


describe Panini::DerivationStrategy::RandomDampened do
  it_behaves_like "basic derivation strategy"  
end


describe Panini::DerivationStrategy::RandomDampened do

  before (:each) do
    @g = Panini::Grammar.new.tap do |grammar|
      grammar.add_nonterminal.add_production([])
    end
  end

  it "raises an exception if the damping factor is too small" do
    lambda { described_class.new(@g, 1.0) }.should raise_error(ArgumentError, "The damping factor must be greater than 0.0 and less than 1.0.")
  end

  it "raises an exception if the damping factor is too large" do
    lambda { described_class.new(@g, 0.0) }.should raise_error(ArgumentError, "The damping factor must be greater than 0.0 and less than 1.0.")
  end

end

describe Panini::DerivationStrategy::RandomDampened, "sentence with an arethmetic expression grammar" do

  before(:each) do
    @grammar = Panini::Grammar.new

    expression = @grammar.add_nonterminal
    term = @grammar.add_nonterminal
    factor = @grammar.add_nonterminal
    identifier = @grammar.add_nonterminal
    number = @grammar.add_nonterminal


    # =============
    # = Terminals =
    # =============
    expression.add_production([term, '+', term])
    expression.add_production([term, '-', term])
    expression.add_production([term])

    term.add_production([factor, '*', term])
    term.add_production([factor, '/', term])
    term.add_production([factor])

    factor.add_production([identifier])
    factor.add_production([number])
    factor.add_production(['(', expression, ')'])

    ('a'..'z').each do |v|
      identifier.add_production([v])
    end

    (0..100).each do |n|
      number.add_production([n])
    end

    Kernel::stub(:rand).and_return(0.3)
  end

  context "with very little damping" do

    before(:each) do
      @deriver = described_class.new(@grammar, 0.999999999999)      
    end

    it "encounters a stack error" do
      lambda { @deriver.sentence }.should raise_error(SystemStackError)
    end
 
  end

  context "with damping" do

    before(:each) do
      @deriver = described_class.new(@grammar)      
    end

    it "returns an expected sentence" do
      @deriver.sentence.should == ["h", "*", "h", "/", "h", "/", "h", "+", "h", "*", "h", "/", "h", "/", "h"]
    end

  end


end