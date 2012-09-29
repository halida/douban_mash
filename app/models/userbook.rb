class Userbook < ActiveRecord::Base
  def json_data
    return {} if self.data.blank?
    @json_data ||= Hash.from_xml(self.data)['entry']
  end

end
