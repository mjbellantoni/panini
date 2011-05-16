require "spec_helper"


describe Panini::DerivationStrategy::DampenedProbabilityProductionChoiceProxy do

  it "responds to #production" do
    described_class.new(Panini::Nonterminal.new).should respond_to(:production)
  end

end


describe Panini::DerivationStrategy::DampenedProbabilityProductionChoiceProxy, "#production" do

  context "with damping 0.50" do

    before(:each) do
      @damping = 0.50
    end

    context "with a production N -> 'a' and rand() -> 0.25" do

      before(:each) do
        n = Panini::Nonterminal.new
        n.add_production(['a'])
        @proxy = described_class.new(n, @damping)
        Kernel::stub(:rand).and_return(0.25)
      end

      it "returns ['a'] after one call" do
        @proxy.production.should == ['a']
      end

      it "returns ['a'] after two calls" do
        @proxy.production
        @proxy.production.should == ['a']
      end

      it "returns ['a'] after three calls" do
        @proxy.production
        @proxy.production
        @proxy.production.should == ['a']
      end

    end

    context "with a production N -> 'a' | 'b' and rand() -> 0.25" do

      before(:each) do
        n = Panini::Nonterminal.new
        n.add_production(['a'])
        n.add_production(['b'])
        @proxy = described_class.new(n, @damping)
        Kernel::stub(:rand).and_return(0.25)
      end

      it "returns ['a'] after one call" do
        @proxy.production.should == ['a']
      end

      it "returns ['a'] after two calls" do
        @proxy.production
        @proxy.production.should == ['a']
      end

      it "returns ['b'] after three calls" do
        @proxy.production
        @proxy.production
        @proxy.production.should == ['b']
      end

    end

    context "with a production N -> 'a' | 'b' | 'c' and rand() -> 0.3" do

      before(:each) do
        n = Panini::Nonterminal.new
        n.add_production(['a'])
        n.add_production(['b'])
        n.add_production(['c'])
        @proxy = described_class.new(n, @damping)
        Kernel::stub(:rand).and_return(0.3)
      end

      it "returns ['a'] after one call" do
        @proxy.production.should == ['a']
      end

      it "returns ['b'] after two calls" do
        @proxy.production
        @proxy.production.should == ['b']
      end

      it "returns ['b'] after three calls" do
        @proxy.production
        @proxy.production
        @proxy.production.should == ['b']
      end

      it "returns ['b'] after four calls" do
        @proxy.production
        @proxy.production
        @proxy.production
        @proxy.production.should == ['b']
      end

      it "returns ['a'] after five calls" do
        @proxy.production
        @proxy.production
        @proxy.production
        @proxy.production
        @proxy.production.should == ['a']
      end

      it "returns ['c'] after six calls" do
        @proxy.production
        @proxy.production
        @proxy.production
        @proxy.production
        @proxy.production
        @proxy.production.should == ['c']
      end

    end

  end

end



describe Panini::DerivationStrategy::DampenedProbabilityProductionChoiceProxy, "#clone" do

  context "with damping 0.50, a production N -> 'a' | 'b' | 'c' and rand() -> 0.3" do

    before(:each) do
      n = Panini::Nonterminal.new
      n.add_production(['a'])
      n.add_production(['b'])
      n.add_production(['c'])
      @proxy = described_class.new(n, 0.50)
      Kernel::stub(:rand).and_return(0.3)
    end

    context "and a clone" do

      before(:each) do
        @clone_proxy = @proxy.clone        
        @clone_proxy.stub(:rand).and_return(0.3)
      end

      context "the original" do
        
        it "returns ['a'] after one call" do
          @proxy.production.should == ['a']
        end

        it "returns ['b'] after two calls" do
          @proxy.production
          @proxy.production.should == ['b']
        end

        it "returns ['b'] after three calls" do
          @proxy.production
          @proxy.production
          @proxy.production.should == ['b']
        end

      end

      context "the clone" do
        
        it "returns ['a'] after one call" do
          @clone_proxy.production.should == ['a']
        end

        it "returns ['b'] after two calls" do
          @clone_proxy.production
          @clone_proxy.production.should == ['b']
        end

        it "returns ['b'] after three calls" do
          @clone_proxy.production
          @clone_proxy.production
          @clone_proxy.production.should == ['b']
        end

      end

    end

  end

end
