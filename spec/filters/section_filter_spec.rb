require 'spec_helper'

describe Legco::Hansard::Filters::SectionFilter do
  describe "-process" do
    let(:doc) {test_doc}

    before do
      subject.process doc
    end

    it "should extract sections" do
      doc.data[:sections].should be_a(Array)
      doc.data[:sections].should_not be_empty
      doc.data[:sections].each do |section|
        section.should_not be_nil
      end
    end

  end
end