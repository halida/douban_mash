class Doubanuser < ActiveRecord::Base
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
