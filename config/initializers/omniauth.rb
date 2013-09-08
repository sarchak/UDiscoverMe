Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  provider :twitter, 
  "ydhUHFd62TxM1kJRy9CMKw", 
  "aRNI6XRX1uSYnW2HblTBYqHE09iZjDrB5tWmCIMSYs"
end