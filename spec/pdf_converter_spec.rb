describe Legco::Hansard::PdfConverter do
  describe "-convert" do
    # this is too slow
    pending "should convert PDF into text" do
      subject.convert("./spec/fixtures/cm1121-translate-c.pdf", "./spec/cm1121-translate-c.txt")
      File.exist?("./spec/cm1121-translate-c.txt").should be_true
    end

    after do
      File.delete("./spec/cm1121-translate-c.txt")
    end
  end
end