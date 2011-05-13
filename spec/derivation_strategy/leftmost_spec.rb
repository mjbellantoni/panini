require "spec_helper"


describe "Grammar with the production S -> _epsilon_" do

  before (:each) do
    @g = Panini::Grammar.new
    @n = @g.add_nonterminal
    @n.add_production([])
  end

  it "generates an empty sentence when using left derivation" do 
    d = Panini::DerivationStrategy::Leftmost.new(@g)
    d.sentence.should be_empty
  end

end



describe "Grammar with the production S -> 'a'" do

  before (:each) do
    @g = Panini::Grammar.new
    @n = @g.add_nonterminal
    @n.add_production(['a'])
  end

  it "generates the sentence ['a'] when using left derivation" do 
    d = Panini::DerivationStrategy::Leftmost.new(@g)
    d.sentence.should == ['a']
  end

end



describe "Grammar with the production S -> A, A -> 'a'" do

  before (:each) do
    @g = Panini::Grammar.new

    @n_s = @g.add_nonterminal
    @n_a = @g.add_nonterminal

    @n_s.add_production([@n_a])
    @n_a.add_production(['a'])
  end

  it "generates the sentence ['a'] when using left derivation" do 
    d = Panini::DerivationStrategy::Leftmost.new(@g)
    d.sentence.should == ['a']
  end

end



describe "Grammar with the production S -> AB, A -> 'a', B -> 'b'" do

  before (:each) do
    @g = Panini::Grammar.new

    @n_s = @g.add_nonterminal
    @n_a = @g.add_nonterminal
    @n_b = @g.add_nonterminal

    @n_s.add_production([@n_a, @n_b])
    @n_a.add_production(['a'])
    @n_b.add_production(['b'])
  end

  it "generates the sentence ['a', 'b'] when using left derivation" do 
    d = Panini::DerivationStrategy::Leftmost.new(@g)
    d.sentence.should == ['a', 'b']
  end

end



describe "Grammar with the production S -> AAB, A -> 'a' | 'x', B -> 'b'" do

  before (:each) do
    @g = Panini::Grammar.new

    @n_s = @g.add_nonterminal
    @n_a = @g.add_nonterminal
    @n_b = @g.add_nonterminal

    @n_s.add_production([@n_a, @n_a, @n_b])
    @n_a.add_production(['a'])
    @n_a.add_production(['x'])
    @n_b.add_production(['b'])
  end

  it "generates the sentence ['a', 'x', 'b'] when using left derivation" do 
    d = Panini::DerivationStrategy::Leftmost.new(@g)
    d.sentence.should == ['a', 'x', 'b']
  end

end



describe "Grammar with the production S -> 'a' | 'b'" do

  before (:each) do
    @g = Panini::Grammar.new
    @n = @g.add_nonterminal
    @n.add_production(['a'])
    @n.add_production(['b'])
  end

  it "generates the sentence ['a'] when using left derivation" do 
    d = Panini::DerivationStrategy::Leftmost.new(@g)
    d.sentence.should == ['a']
  end

end



describe "Grammar with the production S -> S | 'a' | 'b'" do

  before (:each) do
    @g = Panini::Grammar.new
    @n = @g.add_nonterminal
    @n.add_production([@n])
    @n.add_production(['a'])
    @n.add_production(['b'])

    @deriver = Panini::DerivationStrategy::Leftmost.new(@g)
  end

  it "generates the sentence ['a'] first when using left derivation" do 
    @deriver.sentence.should == ['a']
  end

  it "generates the sentence ['b'] second when using left derivation" do 
    @deriver.sentence.should
    @deriver.sentence.should == ['b']
  end

end
