class Match < ActiveRecord::Base
  MATCH_COUNT = 4

  def self.match opt={}
    scope = Doubanuser.where("data != ''")
      .where(gender: opt[:gender])
      .where('id in (select user_id from userevents)')
    scope = scope.where("id not in (?)", opt[:excepts]) if opt[:excepts].count > 0
    if opt[:matches]
      # todo
    end
    scope.random
  end
end
