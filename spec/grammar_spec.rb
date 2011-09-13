require File.expand_path(File.dirname(__FILE__) + '/spec_helper')


describe "Grammar" do

  before (:each) do
    @g = Panini::Grammar.new
  end

  it "responds to #add_nonterminal" do
    @g.should respond_to(:add_nonterminal)
  end

  it "responds to #nonterminals" do
    @g.should respond_to(:nonterminals)
  end

  it "responds to #start" do
    @g.should respond_to(:start)
  end

end



describe "Grammar#add_nonterminal" do

  before (:each) do
    @g = Panini::Grammar.new
    @n = @g.add_nonterminal()
  end

  it "returns a new Panini::Nonterminal" do
    @n.should be_an_instance_of(Panini::Nonterminal)
  end

  it "stores the new Panini::Nonterminal" do
    @g.nonterminals.should have(1).item
    @g.nonterminals[0].should == @n
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
      @g.start.should == @nonterminals[0]
    end    
  end

  context "when a start symbol is specified" do
    before(:each) do
      @g.start = @nonterminals[1]
    end
    it "returns that nonterminal" do
      @g.start.should == @nonterminals[1]
    end    
  end

end
