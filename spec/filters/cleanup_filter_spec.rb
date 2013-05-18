require 'spec_helper'

describe Legco::Hansard::Filters::CleanupFilter do
  describe "-process" do
    it "should remove headers" do
      doc  = Legco::Hansard::Document.new <<-EOF
立法會  ─  2012年 11月 21日  
 
1495
EOF
      subject.process doc
      doc.text.should_not be_include("立法會  ─  2012年 11月 21日")
      doc.text.should_not be_include("1495")
    end
  end
end