require 'spec_helper'

describe Legco::Hansard::Filters::SpeechFilter do
  describe "-process" do
    let(:doc) {
      test_doc "fixtures/cm1121-translate-c-small.txt"
    }

    before do
      subject.process doc
    end

    it "should extract speech" do
      doc.data[:speeches].should be_a(Array)
      doc.data[:speeches].should_not be_empty

      first_speech = doc.data[:speeches].first
      first_speech[:speaker].should == "主席"
      first_speech[:text].should be_include("秘書，請響鐘傳召議員進入會議廳。")

      speech = doc.data[:speeches][1]
      speech[:speaker].should == "主席"
      speech[:text].should be_include("質詢。第一項質詢。")

      speech = doc.data[:speeches][2]
      speech[:speaker].should == "林健鋒議員"
      speech[:text].should be_include("據報，法定最低工資的實施改變了勞動市場的薪酬")
      speech[:text].should be_include("若有調查，物價的升幅為")

      speech = doc.data[:speeches][3]
      speech[:speaker].should == "勞工及福利局局長"
      speech[:text].should be_include("主席，法定最低工資實施以來，政府一直密切注")
      speech[:text].should be_include("定最低工資並不是去年通脹急升的最主要原因。")
    end
  end
end