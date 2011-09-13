require "spec_helper"


describe Panini::DerivationStrategy::Exhaustive do
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

  it "generates the sentence ['a', 'a', 'b'] first" do 
    d = Panini::DerivationStrategy::Exhaustive.new(@g)
    d.sentence.should == ['a', 'a', 'b']
  end

  it "generates the sentence ['a', 'x', 'b'] next" do 
    d = Panini::DerivationStrategy::Exhaustive.new(@g)
    d.sentence
    d.sentence.should == ['a', 'x', 'b']
  end

  it "generates the sentence ['x', 'a', 'b'] next" do 
    d = Panini::DerivationStrategy::Exhaustive.new(@g)
    d.sentence
    d.sentence
    d.sentence.should == ['x', 'a', 'b']
  end

  it "generates the sentence ['x', 'x', 'b'] next" do 
    d = Panini::DerivationStrategy::Exhaustive.new(@g)
    d.sentence
    d.sentence
    d.sentence
    d.sentence.should == ['x', 'x', 'b']
  end

  it "generates nil next" do 
    d = Panini::DerivationStrategy::Exhaustive.new(@g)
    d.sentence
    d.sentence
    d.sentence
    d.sentence
    d.sentence.should be_nil
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
    d = Panini::DerivationStrategy::Exhaustive.new(@g)
    d.sentence.should == ['a']
  end

  it "generates the sentence ['b']" do 
    d = Panini::DerivationStrategy::Exhaustive.new(@g)
    d.sentence
    d.sentence.should == ['b']
  end

end


describe "Grammar with the production S -> xAyBz, A -> 'a' | 'aa', B -> 'b' | 'bb' " do

  before (:each) do
    @g = Panini::Grammar.new

    @n_s = @g.add_nonterminal
    @n_a = @g.add_nonterminal
    @n_b = @g.add_nonterminal

    @n_s.add_production(['x', @n_a, 'y', @n_b, 'z'])
    @n_a.add_production(['a'])
    @n_a.add_production(['aa'])
    @n_b.add_production(['b'])
    @n_b.add_production(['bb'])
  end

  it "generates the sentence ['x', 'a', 'y', 'b', 'z'] first" do 
    d = Panini::DerivationStrategy::Exhaustive.new(@g)
    d.sentence.should == ['x', 'a', 'y', 'b', 'z']
  end

  it "generates the sentence ['x', 'a', 'y', 'bb', 'z'] next" do 
    d = Panini::DerivationStrategy::Exhaustive.new(@g)
    d.sentence.should
    d.sentence.should == ['x', 'a', 'y', 'bb', 'z']
  end

  it "generates the sentence ['x', 'aa', 'y', 'b', 'z'] next" do 
    d = Panini::DerivationStrategy::Exhaustive.new(@g)
    d.sentence.should
    d.sentence.should
    d.sentence.should == ['x', 'aa', 'y', 'b', 'z']
  end

end