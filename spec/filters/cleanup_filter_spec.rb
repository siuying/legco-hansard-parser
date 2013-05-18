require 'spec_helper'

describe Legco::Hansard::Filters::CleanupFilter do
  describe "-process" do
    it "should remove headers" do
      doc  = Legco::Hansard::Document.new <<-EOF
立法會  ─  2012年 11月 21日  
 
1493 
 
會議過程正式紀錄 
 
2012年 11月 21日星期三  
 
上午 11時正會議開始  
 
 
出席議員： 
 
主席曾鈺成議員 , G.B.S., J.P. 
 
何俊仁議員  
 
李卓人議員  
 
涂謹申議員  
 
陳鑑林議員 , S.B.S., J.P. 
 
梁耀忠議員  
 
劉皇發議員 , 大紫荊勳賢 , G.B.S., J.P. 
 
劉慧卿議員 , J.P. 
 
譚耀宗議員 , G.B.S., J.P. 
 
石禮謙議員 , S.B.S., J.P. 
 
馮檢基議員 , S.B.S., J.P. 
 
方剛議員 , S.B.S., J.P. 
 
王國興議員 , M.H. 
 
李國麟議員 , S.B.S., J.P. 
 
立法會  ─  2012年 11月 21日  
 
1494 
林健鋒議員 , G.B.S., J.P. 
 
梁君彥議員 , G.B.S., J.P. 
 
黃定光議員 , S.B.S., J.P. 
 
湯家驊議員 , S.C. 
 
何秀蘭議員  
 
李慧琼議員 , J.P. 
 
林大輝議員 , S.B.S., J.P. 
 
陳克勤議員 , J.P. 
 
陳健波議員 , B.B.S., J.P. 
 
梁美芬議員 , J.P. 
 
梁家騮議員  
 
張國柱議員  
 
黃國健議員 , B.B.S. 
 
葉國謙議員 , G.B.S., J.P. 
 
葉劉淑儀議員 , G.B.S., J.P. 
 
謝偉俊議員 , J.P. 
 
梁家傑議員 , S.C. 
 
梁國雄議員  
 
陳偉業議員  
 
黃毓民議員  
立法會  ─  2012年 11月 21日  
 
1495 
毛孟靜議員  
EOF
      subject.process doc
      doc.text.should_not be_include("立法會  ─  2012年 11月 21日")
      doc.text.should_not be_include("1495")
      doc.text.should be_include("黃毓民議員")
      doc.text.should be_include("毛孟靜議員")
    end
  end
end