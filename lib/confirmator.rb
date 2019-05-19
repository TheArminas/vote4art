class Confirmator
  END_POINT = 'https://apinode.vote4art.eu/rewards'.freeze

  def initialize(params, user)
    @params = params
    @user = user
  end

  def headers
    {
        'Content-Type': 'application/json',
        'kasyra': 'naujas prikolas'
    }
  end

  def connect
    res = HTTP.headers(headers).post(
      END_POINT,
      json: {
        reward: {
          hash: params[:hash],
          lat: params[:lat],
          long: params[:long]
        }
      }
    )

    if res.status.to_sym == :ok
      user.rewards.create(params)
    end
  end

  private

  attr_reader :params, :user
end
