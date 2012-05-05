require 'douban'

class Doubanapi
  # DOUBAN_APIKEY = '0fb6d0a851af01a12f2471f8f50d04e3'
  # DOUBAN_SECRET = 'c59e3be2ccdde999'
  DOUBAN_APIKEY = '0f89b8bc396423112e9d2a34ac2c6933'
  DOUBAN_SECRET = '4e0d52e13eb41484'

  def self.get token = nil
    douban = Douban::Authorize.new DOUBAN_APIKEY, DOUBAN_SECRET
    douban.access_token = token if token
    douban
  end

end
