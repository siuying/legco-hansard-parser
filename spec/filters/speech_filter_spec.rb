require 'spec_helper'

describe Legco::Handsard::Filters::SpeechFilter do
  describe "-process" do
    let(:doc) {test_doc}

    before do
      subject.process doc
    end

    it "should extract speech" do
      doc.data[:speeches].should be_a(Array)
      doc.data[:speeches].should_not be_empty

      # binding.pry
    end

  end
end