require 'spec_helper'

describe Legco::Handsard::Filter::CleanupFilter do
  describe "-process" do
    it "should remove headers" do
      doc  = test_doc
      subject.process doc
      doc.text.should_not be_include("立法會 ─ 2012年11月21日 \n1495 ")
      doc.text.should_not be_include("立法會 ─ 2012年11月21日 \n1496 ")
    end
  end
end