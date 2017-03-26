require File.expand_path(File.dirname(__FILE__) + '/spec_helper')


describe "Grammar" do

  before (:each) do
    @g = Panini::Grammar.new
  end

  it "responds to #add_nonterminal" do
    expect(@g).to respond_to(:add_nonterminal)
  end

  it "responds to #nonterminals" do
    expect(@g).to respond_to(:nonterminals)
  end

  it "responds to #start" do
    expect(@g).to respond_to(:start)
  end

end



describe "Grammar#add_nonterminal" do

  before (:each) do
    @g = Panini::Grammar.new
    @n = @g.add_nonterminal()
  end

  it "returns a new Panini::Nonterminal" do
    expect(@n).to be_an_instance_of(Panini::Nonterminal)
  end

  it "stores the new Panini::Nonterminal" do
    expect(@g.nonterminals.count).to eq(1)
    expect(@g.nonterminals[0]).to eq(@n)
  end

end



describe "Grammar#start" do

  before (:each) do
    @g = Panini::Grammar.new
    @nonterminals = (0...3).to_a.map do
      @g.add_nonterminal
    end
  end

  context "when a start symbol is not specified" do
    it "returns the first nonterminal" do
      expect(@g.start).to eq(@nonterminals[0])
    end
  end

  context "when a start symbol is specified" do
    before(:each) do
      @g.start = @nonterminals[1]
    end
    it "returns that nonterminal" do
      expect(@g.start).to eq(@nonterminals[1])
    end
  end

end
