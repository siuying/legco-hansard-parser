require 'nokogiri'
require 'open-uri'

module Legco
  module Handsard
    class Lister
      HANDSARD_URL = 'http://legco.gov.hk/general/chinese/counmtg/yr12-16/mtg_1213.htm'

      def list
        doc = Nokogiri::HTML(open(HANDSARD_URL))
        hansard_table = doc.css("#hansard").first.parent
        hansard_table.css("table")[3].css("tr").collect do |row|
          columns = row.css("td") 
          if columns && columns.size == 5
            date = columns[0].text.strip
            agenda = columns[1].css("a").collect {|a| URI.join(HANDSARD_URL, a["href"]).to_s }
            minutes = columns[2].css("a").collect {|a| URI.join(HANDSARD_URL, a["href"]).to_s }.select {|url| url =~ %r{minutes} }
            votings = columns[2].css("a").collect {|a| URI.join(HANDSARD_URL, a["href"]).to_s }.select {|url| url =~ %r{voting} }
            hansard = columns[3].css("a").collect {|a| URI.join(HANDSARD_URL, a["href"]).to_s }
            floor = columns[4].css("a").collect {|a| URI.join(HANDSARD_URL, a["href"]).to_s }
            {
              :date => date, 
              :agenda => agenda, 
              :minutes => minutes, 
              :votings => votings,
              :hansard => hansard, 
              :floor => floor
            }
          end
        end.compact
      end
    end
  end
end