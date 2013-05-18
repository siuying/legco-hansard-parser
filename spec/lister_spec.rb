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
        handsard[:agenda].each {|url| 
          url.should =~ %r{^http} 
          url.should =~ %r{agenda} 
        } 
        
        handsard[:minutes].should be_a(Array)
        handsard[:minutes].each {|url| 
          url.should =~ %r{^http} 
          url.should =~ %r{minutes} 
        } 
        
        handsard[:votings].should be_a(Array)
        handsard[:votings].each {|url| 
          url.should =~ %r{^http} 
          url.should =~ %r{voting} 
        } 

        handsard[:hansard].should be_a(Array)
        handsard[:hansard].each {|url| 
          url.should =~ %r{^http} 
          url.should =~ %r{hansard} 
        }  

        handsard[:floor].should be_a(Array)
        handsard[:floor].each {|url| 
          url.should =~ %r{^http} 
          url.should =~ %r{floor} 
        }   
      end
    end
  end
end