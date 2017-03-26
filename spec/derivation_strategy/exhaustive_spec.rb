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
    expect(d.sentence).to eq(['a', 'a', 'b'])
  end

  it "generates the sentence ['a', 'x', 'b'] next" do
    d = Panini::DerivationStrategy::Exhaustive.new(@g)
    d.sentence
    expect(d.sentence).to eq(['a', 'x', 'b'])
  end

  it "generates the sentence ['x', 'a', 'b'] next" do
    d = Panini::DerivationStrategy::Exhaustive.new(@g)
    d.sentence
    d.sentence
    expect(d.sentence).to eq(['x', 'a', 'b'])
  end

  it "generates the sentence ['x', 'x', 'b'] next" do
    d = Panini::DerivationStrategy::Exhaustive.new(@g)
    d.sentence
    d.sentence
    d.sentence
    expect(d.sentence).to eq(['x', 'x', 'b'])
  end

  it "generates nil next" do
    d = Panini::DerivationStrategy::Exhaustive.new(@g)
    d.sentence
    d.sentence
    d.sentence
    d.sentence
    expect(d.sentence).to be_nil
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
    expect(d.sentence).to eq(['a'])
  end

  it "generates the sentence ['b']" do
    d = Panini::DerivationStrategy::Exhaustive.new(@g)
    d.sentence
    expect(d.sentence).to eq(['b'])
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
    expect(d.sentence).to eq(['x', 'a', 'y', 'b', 'z'])
  end

  it "generates the sentence ['x', 'a', 'y', 'bb', 'z'] next" do
    d = Panini::DerivationStrategy::Exhaustive.new(@g)
    d.sentence
    expect(d.sentence).to eq(['x', 'a', 'y', 'bb', 'z'])
  end

  it "generates the sentence ['x', 'aa', 'y', 'b', 'z'] next" do
    d = Panini::DerivationStrategy::Exhaustive.new(@g)
    d.sentence
    d.sentence
    expect(d.sentence).to eq(['x', 'aa', 'y', 'b', 'z'])
  end

end


describe "Grammar with the production S -> xAyBz, A -> eps | 'a', B -> eps | 'b', and length limit of 4 " do

  before (:each) do
    @g = Panini::Grammar.new

    @n_s = @g.add_nonterminal
    @n_a = @g.add_nonterminal
    @n_b = @g.add_nonterminal

    @n_s.add_production(['x', @n_a, 'y', @n_b, 'z'])
    @n_a.add_production([])
    @n_a.add_production(['a'])
    @n_b.add_production([])
    @n_b.add_production(['b'])
  end

  it "generates the sentence ['x', 'y', 'z'] first" do
    d = Panini::DerivationStrategy::Exhaustive.new(@g, 4)
    expect(d.sentence).to eq(['x', 'y', 'z'])
  end

  it "generates the sentence ['x', 'y', 'b', 'z'] next" do
    d = Panini::DerivationStrategy::Exhaustive.new(@g, 4)
    d.sentence
    expect(d.sentence).to eq(['x', 'y', 'b', 'z'])
  end

  it "generates the sentence ['x', 'a', 'y', 'z'] next" do
    d = Panini::DerivationStrategy::Exhaustive.new(@g, 4)
    d.sentence
    d.sentence
    expect(d.sentence).to eq(['x', 'a', 'y', 'z'])
  end

end