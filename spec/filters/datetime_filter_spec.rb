require 'spec_helper'

describe Legco::Handsard::Filters::DatetimeFilter do
  let(:doc) {test_doc}

  before do
    subject.process doc
  end

  describe "-process" do
    it "should extract date" do
      doc.date.strftime("%Y%m%d").should == "20121121"
    end
  end
end