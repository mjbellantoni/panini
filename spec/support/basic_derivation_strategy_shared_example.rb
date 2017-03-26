require "spec_helper"

# Some basic tests to make sure that a strategy can deal with trivial
# grammars.  Since these grammars can only create a single sentence, all
# strategies should work.

shared_examples_for "basic derivation strategy" do

  describe "with the production S -> _epsilon_" do

    before (:each) do
      @g = Panini::Grammar.new
      @n = @g.add_nonterminal
      @n.add_production([])
    end

    it "generates an empty sentence" do
      d = described_class.new(@g)
      expect(d.sentence).to be_empty
    end

  end


  describe "with the production S -> 'a'" do

    before (:each) do
      @g = Panini::Grammar.new
      @n = @g.add_nonterminal
      @n.add_production(['a'])
    end

    it "generates the sentence ['a']" do
      d = described_class.new(@g)
      expect(d.sentence).to eq(['a'])
    end

  end



  describe "with the productions S -> A, A -> 'a'" do

    before (:each) do
      @g = Panini::Grammar.new

      @n_s = @g.add_nonterminal
      @n_a = @g.add_nonterminal

      @n_s.add_production([@n_a])
      @n_a.add_production(['a'])
    end

    it "generates the sentence ['a']" do
      d = described_class.new(@g)
      expect(d.sentence).to eq(['a'])
    end

  end



  describe "with the productions S -> AB, A -> 'a', B -> 'b'" do

    before (:each) do
      @g = Panini::Grammar.new

      @n_s = @g.add_nonterminal
      @n_a = @g.add_nonterminal
      @n_b = @g.add_nonterminal

      @n_s.add_production([@n_a, @n_b])
      @n_a.add_production(['a'])
      @n_b.add_production(['b'])
    end

    it "generates the sentence ['a', 'b']" do
      d = described_class.new(@g)
      expect(d.sentence).to eq(['a', 'b'])
    end

  end


end