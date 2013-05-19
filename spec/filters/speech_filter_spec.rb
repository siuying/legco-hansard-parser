require 'spec_helper'

describe Legco::Hansard::Filters::SpeechFilter do
  describe "-process" do
    let(:doc) {test_doc}

    before do
      subject.process doc
    end

    it "should extract speech" do
      doc.data[:speeches].should be_a(Array)
      doc.data[:speeches].should_not be_empty
      puts doc.data[:speeches].collect{|s| s[:speaker]}
    end
  end
end