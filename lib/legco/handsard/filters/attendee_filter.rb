module Legco
  module Handsard
    module Filter
      class AttendeeFilter
        attr_reader :present_members, :absent_members, :officers, :clerks

        MEMBERS_REGEX  = %r{出席議員(.+?)(缺席議員|出席政府官員|列席秘書|提交文件|作出立法會誓言|主席：)}m
        MEMBERS_NAME_REGEX   = %r{(\n|\A)(主席)?(.+)議員\s*?}

        ABSENT_REGEX = %r{缺席議員(.+?)(出席政府官員|列席秘書|提交文件|作出立法會誓言|主席：)}m

        PUBLIC_OFFICIER_REGEX = %r{出席政府官員(.+?)(列席秘書|提交文件|作出立法會誓言|主席：)}m
        PUBLIC_OFFICIER_NAME_REGEX = %r{(\n|\A)(.+)(司長|局長)(.+)(先生|女士|小姐|教授|醫生),?.*?\n?}m

        CLERK_REGEX = %r{列席秘書(.+?)(提交文件|作出立法會誓言|主席：)}m
        CLERK_NAME_REGEX = %r{(\n|\A)(秘書長|副秘書長|助理秘書長)(.+)(先生|女士|小姐|教授|醫生),?.*?\n?}m

        def process(doc)
          attendee_matches = doc.text.match MEMBERS_REGEX
          @present_members = attendee_matches[1].scan(MEMBERS_NAME_REGEX).collect{|a| a[2]} if attendee_matches

          absent_matches = doc.text.match ABSENT_REGEX
          @absent_members = absent_matches[1].scan(MEMBERS_NAME_REGEX).collect{|a| a[2]} if absent_matches

          public_officer_matches = doc.text.match PUBLIC_OFFICIER_REGEX
          @officers = public_officer_matches[1].scan(PUBLIC_OFFICIER_NAME_REGEX).collect{|a| a[3] }

          clerk_matches = doc.text.match CLERK_REGEX
          @clerks = clerk_matches[1].scan(CLERK_NAME_REGEX).collect{|a| a[3] }

        end
      end
    end
  end
end