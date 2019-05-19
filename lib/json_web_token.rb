class JsonWebToken
  class << self
  # exp pasikeisti i 14d.
  def encode(payload, secret, exp = 24.hours.from_now)
     payload[:exp] = exp.to_i
     JWT.encode(payload, secret)
   end
  #  Rails.application.secrets.secret_key_base
   def decode(token, secret)
     body = JWT.decode(token, secret)[0]
     HashWithIndifferentAccess.new body
   rescue
     nil
   end
  end
end
