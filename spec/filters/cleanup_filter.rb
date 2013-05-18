require 'spec_helper'

describe Legco::Handsard::Filter::CleanupFilter do
  describe "-process" do
    it "should remove headers" do
      data = open("../fixtures/cm1121-translate-c-small.txt").read
      doc  = Legco::Handsard::Document.new(data)
      subject.process doc
      doc.text.should_not be_include("立法會 ─ 2012年11月21日")
      doc.text.should_not be_include("1493")
      doc.text.should_not be_include("2012年11月21日 \n1496 ")
  end
end