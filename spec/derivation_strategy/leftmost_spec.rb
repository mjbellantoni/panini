require "spec_helper"


describe Panini::DerivationStrategy::Leftmost do
  it_behaves_like "basic derivation strategy"  
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

  it "generates the sentence ['a', 'x', 'b']" do 
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

  it "generates the sentence ['a']" do 
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

  it "generates the sentence ['a'] first" do 
    @deriver.sentence.should == ['a']
  end

  it "generates the sentence ['b'] second" do 
    @deriver.sentence.should
    @deriver.sentence.should == ['b']
  end

end
