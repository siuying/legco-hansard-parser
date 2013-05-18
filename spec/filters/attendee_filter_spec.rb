require 'spec_helper'

describe Legco::Handsard::Filter::AttendeeFilter do
  describe "-process" do
    before do
      @doc  = test_doc
      subject.process @doc
    end

    it "should find present members" do
      subject.present_members.should be_a(Array)
      subject.present_members.should_not be_empty
    end

    it "should find absent members" do
      subject.absent_members.should be_a(Array)
      subject.absent_members.should_not be_empty
    end

    it "should find officers" do
      subject.officers.should be_a(Array)
      subject.officers.should_not be_empty
    end

    it "should find clerks" do
      subject.clerks.should be_a(Array)
      subject.clerks.should_not be_empty
    end
  end
end