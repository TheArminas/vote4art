class JsonWebToken
  class << self
    def encode(payload, exp = 24.hours.from_now)
     payload[:exp] = exp.to_i
     JWT.encode(payload, "testas")
   end
  #  Rails.application.secrets.secret_key_base
   def decode(token)
     body = JWT.decode(token, "testas")[0]
     HashWithIndifferentAccess.new body
   rescue
     nil
   end
  end
end
