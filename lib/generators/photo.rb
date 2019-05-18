module Generators
  class Photo
    END_POINT = 'https://apinode.vote4art.eu/pixels'

    def initialize(pixels:)
      @pixels = pixels
    end

    def connect
      headers = {
        'Content-Type': 'application/json',
        'kasyra': 'naujas prikolas'
      }
  
      res = HTTP.headers(headers).post(
        END_POINT,
        json: {
          pixels: pixels,
          url: Class.const_get('Photo').last&.url ||= false
        })
      if res.status.to_sym == :ok
        data = JSON.parse(res.body)
        ::Photo.create(url: data["photo_path"], name: data["domain"])
      end
    end

    private 

    attr_reader :pixels
  end
end
