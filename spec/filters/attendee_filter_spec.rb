require 'spec_helper'

describe Legco::Handsard::Filter::AttendeeFilter do
  describe "-process" do
    let(:doc) {test_doc}

    before do
      subject.process doc
    end

    it "should find present members" do
      doc.data[:present_members].should be_a(Array)
      doc.data[:present_members].should_not be_empty
    end

    it "should find absent members" do
      doc.data[:absent_members].should be_a(Array)
      doc.data[:absent_members].should_not be_empty
    end

    it "should find officers" do
      doc.data[:officers].should be_a(Array)
      doc.data[:officers].should_not be_empty
    end

    it "should find clerks" do
      doc.data[:clerks].should be_a(Array)
      doc.data[:clerks].should_not be_empty
    end
  end
end