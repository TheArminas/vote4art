class Confirmator
  END_POINT = 'https://apinode.vote4art.eu/rewards'.freeze

  def initialize(params, user)
    @params = params
    @user = user
  end

  def connect
    headers = {
      'Content-Type': 'application/json',
      'kasyra': 'naujas prikolas'
    }

    res = HTTP.headers(headers).post(
      END_POINT,
      json: {
        hash: params[:hash],
        lat:  params[:lat],
        long: params[:long]
      }
    )
    if res.status.to_sym == :ok
      res = JSON.parse(res.body)
      new_params = res.merge(lat: params[:lat], long: params[:long]).symbolize_keys
      if user
        rew = user.rewards.create(new_params) unless user.rewards.find_by(tipas: params[:tipas]).present?
        if rew
          user.increment!(:pix_rew, 84)
        end
      end
    end
  end

  private

  attr_reader :params, :user
end
