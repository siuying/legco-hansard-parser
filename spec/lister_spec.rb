require 'spec_helper'

describe Legco::Handsard::Lister do
  describe "-list" do
    use_vcr_cassette "list"

    it "should return list handsards" do
      handsards = subject.list
      handsards.should_not be_nil
      handsards.should be_a(Array)

      handsards.each do |handsard|
        handsard.should_not be_nil
        handsard[:date].should_not be_nil
        
        handsard[:agenda].should be_a(Array)
        handsard[:agenda].each {|url| url.should =~ %r{^http} } 
        
        handsard[:minutes].should be_a(Array)
        handsard[:minutes].each {|url| url.should =~ %r{^http} } 

        handsard[:handsard].should be_a(Array)
        handsard[:handsard].each {|url| url.should =~ %r{^http} } 

        handsard[:floor].should be_a(Array)
        handsard[:floor].each {|url| url.should =~ %r{^http} } 
      end
    end
  end
end