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

      speeches = doc.data[:speeches].select {|sp| sp[:type] == :speech}

      speech = speeches.first
      speech[:speaker][:title].should == "主席"
      speech[:speaker][:name].should == nil
      speech[:speaker][:full].should == "主席"
      speech[:text].should be_include("秘書，請響鐘傳召議員進入會議廳。")
      speech[:supplement].should be_include("下列文件是根據《議事規則》第21(2)條")

      speech = speeches[1]
      speech[:speaker][:title].should == "主席"
      speech[:speaker][:name].should == nil
      speech[:speaker][:full].should == "主席"
      speech[:text].should be_include("質詢。第一項質詢。")
      speech[:supplement].should be_nil

      speech = speeches[2]
      speech[:speaker][:title].should == "議員"
      speech[:speaker][:name].should == "林健鋒"
      speech[:speaker][:full].should == "林健鋒議員"
      speech[:text].should be_include("據報，法定最低工資的實施改變了勞動市場的薪酬")
      speech[:text].should be_include("若有調查，物價的升幅為")

      speech = speeches[3]
      speech[:speaker][:title].should == "勞工及福利局局長"
      speech[:speaker][:name].should == nil
      speech[:speaker][:full].should == "勞工及福利局局長"
      speech[:text].should be_include("主席，法定最低工資實施以來，政府一直密切注")
      speech[:text].should be_include("定最低工資並不是去年通脹急升的最主要原因。")
      speech[:supplement].should be_include("2011年按行業劃分的總薪酬開支增加率")
    end

    it "should extract action" do
      doc.data[:speeches].should be_a(Array)
      doc.data[:speeches].should_not be_empty

      speeches = doc.data[:speeches]

      speech = speeches.first
      speech[:type].should == :speech

      speech = speeches[1]
      speech[:type].should == :action
      speech[:text].should == "在傳召鐘響後，多位議員進入會議廳"
    end
  end
end