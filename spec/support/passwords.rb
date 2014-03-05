require 'rotp'

def generate_one_time_password(shared_secret)
  ROTP::TOTP.new(shared_secret).now
end
