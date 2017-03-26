require File.expand_path(File.dirname(__FILE__) + '/spec_helper')


describe "Nonterminal" do

  before (:each) do
    @n = Panini::Nonterminal.new
  end

  it "responds to #add_production" do
    expect(@n).to respond_to(:add_production)
  end

  it "responds to #productions" do
    expect(@n).to respond_to(:productions)
  end

end


describe "Nonterminal#add_production with a non-Array arument" do

  before (:each) do
    @n = Panini::Nonterminal.new
  end

  it "throws an error" do
    expect do
     @n.add_production('a')
   end.to raise_error(ArgumentError, "The production must be an Array.")
  end

end


describe "Nonterminal#add_production with a single production" do

  before (:each) do
    @n = Panini::Nonterminal.new
    @p = @n.add_production(['a', 'b', 'c'])
  end

  it "returns nil" do
    expect(@p).to be_nil
  end

  it "stores the production" do
    expect(@n.productions.count).to eq(1)
    expect(@n.productions[0]).to eq(['a', 'b', 'c'])
  end

end



describe "Nonterminal#add_production with two productions" do

  before (:each) do
    @n = Panini::Nonterminal.new
    @p1 = @n.add_production(['a', 'b', 'c'])
    @p2 = @n.add_production(['x', 'y', 'z'])
  end

  it "returns nil" do
    expect(@p1).to be_nil
    expect(@p2).to be_nil
  end

  it "stores the productions" do
    expect(@n.productions.count).to eq(2)
  end

  it "stores the first one added first" do
    expect(@n.productions[0]).to eq(['a', 'b', 'c'])
  end

  it "stores the second one added last" do
    expect(@n.productions[1]).to eq(['x', 'y', 'z'])
  end

end
