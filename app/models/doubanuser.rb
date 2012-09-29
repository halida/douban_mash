class Doubanuser < ActiveRecord::Base

  has_many :books, class_name: "Userbook", foreign_key: "user_id"
  has_many :userevents, foreign_key: "user_id"

  def json_data
    return {} if self.data.blank?
    @json_data ||= Hash.from_xml(self.data)['entry']
  end

  def img
    links = self.json_data['link']
    links = links.reject{|v| v['rel'] != 'icon'}
    return "" if links.count <= 0
    links = links[0]['href']
  end

  def big_img
    img = self.img
    img.sub('/u', '/ul')
  end

  def name
    self.json_data['title']
  end

  def link
    links = self.json_data['link']
    links = links.reject{|v| v['rel'] != 'alternate'}
    return "" if links.count <= 0
    links = links[0]['href']
  end

end
