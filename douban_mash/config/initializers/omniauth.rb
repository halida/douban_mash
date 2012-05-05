Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :douban, "0f89b8bc396423112e9d2a34ac2c6933", "4e0d52e13eb41484"
end
