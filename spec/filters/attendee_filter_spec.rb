require 'spec_helper'

describe Legco::Hansard::Filters::AttendeeFilter do
  describe "-process" do
    let(:doc) {test_doc}

    before do
      subject.process doc
    end

    it "should find present members" do
      doc.data[:present_members].should be_a(Array)
      doc.data[:present_members].should_not be_empty
      
      doc.data[:present_members].should be_include("曾鈺成")
      doc.data[:present_members].should be_include("譚耀宗")
      doc.data[:present_members].should be_include("黃毓民")
      doc.data[:present_members].should be_include("謝偉銓")
    end

    it "should find absent members" do
      doc.data[:absent_members].should be_a(Array)
      doc.data[:absent_members].should_not be_empty
      doc.data[:absent_members].should be_include("張宇人")
    end

    it "should find officers" do
      doc.data[:officers].should be_a(Array)
      doc.data[:officers].should_not be_empty
      doc.data[:officers].length.should == 6
      doc.data[:officers].should be_include("曾俊華")
      doc.data[:officers].should be_include("陳茂波")
    end

    it "should find clerks" do
      doc.data[:clerks].should be_a(Array)
      doc.data[:clerks].should_not be_empty
      doc.data[:clerks].length.should == 5

      doc.data[:clerks].should be_include("陳維安")
      doc.data[:clerks].should be_include("馬朱雪履")
    end
  end
end