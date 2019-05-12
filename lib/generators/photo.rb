module Generators
  class Photo
    END_POINT = 'http://vote4art.eu:20177'

    def initialize(pixels:)
      @pixels = pixels
    end

    headers = {
      'Content-Type': 'application/json',
      'kasyra': 'naujas prikolas'
    }

    def connect
      res = HTTP.headers(headers).post(END_POINT,
                                         json: {
                                           pixels: pixels.to_json,
                                           url: Photo.last&.url
                                         } 
                                       )
      if res.status.to_sym == :created
        Photo.create(url: res.body.url, name: res.body.name)
      end
    end

    private 

    attr_reader :pixels
  end
end
