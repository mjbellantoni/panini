require File.expand_path(File.dirname(__FILE__) + '/spec_helper')


describe "Nonterminal" do

  before (:each) do
    @n = Panini::Nonterminal.new
  end

  it "responds to #add_production" do
    @n.should respond_to(:add_production)
  end

  it "responds to #productions" do
    @n.should respond_to(:productions)
  end

end


describe "Nonterminal#add_production with a non-Array arument" do

  before (:each) do
    @n = Panini::Nonterminal.new
  end

  it "throws an error" do
    lambda { @n.add_production('a') }.should raise_error(ArgumentError, "The production must be an Array.")
  end

end


describe "Nonterminal#add_production with a single production" do

  before (:each) do
    @n = Panini::Nonterminal.new
    @p = @n.add_production(['a', 'b', 'c'])
  end

  it "returns nil" do
    @p.should be_nil
  end

  it "stores the production" do
    @n.productions.should have(1).item
    @n.productions[0].should == ['a', 'b', 'c']
  end

end



describe "Nonterminal#add_production with two productions" do

  before (:each) do
    @n = Panini::Nonterminal.new
    @p1 = @n.add_production(['a', 'b', 'c'])
    @p2 = @n.add_production(['x', 'y', 'z'])
  end

  it "returns nil" do
    @p1.should be_nil
    @p2.should be_nil
  end

  it "stores the productions" do
    @n.productions.should have(2).items
  end

  it "stores the first one added first" do
    @n.productions[0].should == ['a', 'b', 'c']    
  end

  it "stores the second one added last" do
    @n.productions[1].should == ['x', 'y', 'z']    
  end

end
