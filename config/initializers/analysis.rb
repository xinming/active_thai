require 'json'
require 'open-uri'
require "net/http"
require "uri"

GOOGLE_KEY = 'ABQIAAAAfYBa5DNd8gNER1NCeR_ThRS26eAAQ6XyK1ErrNGnEvPxCdasxRRlfUEZkktPyde__kzhD8vu3ZzZIQ'
GOOGLE_REFERER = "http://designgonemad.com"


def google_count(word)
  search_query = URI.escape("\"#{word}\"")
  api_path = "http://ajax.googleapis.com/ajax/services/search/web"
  api = URI.parse(api_path)
  headers = {'Referer' => 'http://designgonemad.com'}
  data = "?v=1.0&key=#{GOOGLE_KEY}&q=#{search_query}&rsz=large"
  apicall = Net::HTTP.new(api.host)
  response = apicall.get2(api.path + data, headers)
  # begin
    return JSON.parse(response.body)["responseData"]["cursor"]["estimatedResultCount"].to_i
  # rescue NoMethodError
    # puts "EXCEPTION: ./utils.rb:71:in `google_count': undefined method `[]' for nil:NilClass (NoMethodError)"
    # return 0
  # end
end