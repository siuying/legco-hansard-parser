require 'spec_helper'

describe Legco::Handsard::Filters::DatetimeFilter do
  let(:doc) {
    Legco::Handsard::Document.new <<-EOF
會議過程正式紀錄 
 
2012年11月21日星期三 
 
上午11時正會議開始 
 
 
出席議員： 
EOF
  }

  before do
    subject.process doc
  end

  describe "-process" do
    it "should extract date" do
      doc.date.strftime("%Y/%m/%d %H:%M").should == "2012/11/21 11:00"
    end
  end
end