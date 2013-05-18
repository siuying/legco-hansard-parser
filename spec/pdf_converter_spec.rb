describe Legco::Handsard::PdfConverter do
  describe "-convert" do
    # this is too slow
    pending "should convert PDF into text" do
      subject.convert("./spec/fixtures/cm1121-translate-c.pdf", "./spec/output.txt")
      File.exist?("./spec/output.txt").should be_true
    end

    after do
      File.delete("spec/output.txt")
    end
  end
end