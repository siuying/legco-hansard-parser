module Legco
  module Hansard
    module Filters
      class AttendeeFilter
        MEMBERS_REGEX  = %r{出席議員(.+?)(缺席議員|出席政府官員|列席秘書|提交文件|作出立法會誓言|主席：)}m
        MEMBERS_NAME_REGEX   = %r{(\n|\A)(主席)?(.+)議員\s*?}

        ABSENT_REGEX = %r{缺席議員(.+?)(出席政府官員|列席秘書|提交文件|作出立法會誓言|主席：)}m

        PUBLIC_OFFICIER_REGEX = %r{出席政府官員(.+?)(列席秘書|提交文件|作出立法會誓言|主席：)}m
        PUBLIC_OFFICIER_NAME_REGEX = %r{(\n|\A)(.+)(司長|局長)(.+)(先生|女士|小姐|教授|醫生),?.*?}

        CLERK_REGEX = %r{列席秘書(.+?)(提交文件|作出立法會誓言|主席：)}m
        CLERK_NAME_REGEX = %r{(\n|\A)(秘書長|副秘書長|助理秘書長)(.+)(先生|女士|小姐|教授|醫生).*?}

        def process(doc)
          attendee_matches = doc.text.match MEMBERS_REGEX
          doc.data[:present_members] = attendee_matches[1].scan(MEMBERS_NAME_REGEX).collect{|a| a[2].strip } if attendee_matches

          absent_matches = doc.text.match ABSENT_REGEX
          doc.data[:absent_members] = absent_matches[1].scan(MEMBERS_NAME_REGEX).collect{|a| a[2].strip} if absent_matches

          public_officer_matches = doc.text.match PUBLIC_OFFICIER_REGEX
          doc.data[:officers] = public_officer_matches[1].scan(PUBLIC_OFFICIER_NAME_REGEX).collect{|a| a[3].strip } if public_officer_matches

          clerk_matches = doc.text.match CLERK_REGEX
          doc.data[:clerks] = clerk_matches[1].scan(CLERK_NAME_REGEX).collect{|a| a[2].strip } if clerk_matches
        end
      end
    end
  end
end