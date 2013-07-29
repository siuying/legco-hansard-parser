require 'spec_helper'

describe Legco::Hansard::Filters::DatetimeFilter do
  let(:doc) {
    Legco::Hansard::Document.new <<-EOF
立法會  ─  2013年 1月 9日  
 
2995 
 
會議過程正式紀錄 
 
2013年 1月 9日星期三  
 
上午 11時正會議開始  
 
 
出席議員： 
 
EOF
  }

  before do
    subject.process doc
  end

  describe "-process" do
    it "should extract date" do
      doc.date.strftime("%Y/%m/%d %H:%M").should == "2013/01/09 11:00"
    end
  end
end