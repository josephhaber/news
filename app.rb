require "sinatra"
require "sinatra/reloader"
require "httparty"
def view(template); erb template.to_sym; end

get "/" do
  ### Get the weather
  # Evanston, Kellogg Global Hub... replace with a different location if you want
  lat = 42.0574063
  long = -87.6722787

  units = "imperial" # or metric, whatever you like
  key = "3418b3f839a128a7311a1ddd50f7ed1d" # replace this with your real OpenWeather API key

  # construct the URL to get the API data (https://openweathermap.org/api/one-call-api)
  url = "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{long}&units=#{units}&appid=#{key}"

  # make the call
  @forecast = HTTParty.get(url).parsed_response.to_hash

today = "It is currently #{@forecast["daily"][0]["temp"]["max"]} degrees and #{@forecast["daily"][0]["weather"][0]["description"]}"
tomorrow = "Tomorrow, it will be #{@forecast["daily"][1]["temp"]["max"]} degrees and #{@forecast["daily"][1]["weather"][0]["description"]}"

@days = [today]
@days2 = [tomorrow]

loopie = []
  day_number = 0
    for day in @forecast["daily"]
        loopie << "#{day_number} days from now, there will be a high of #{day["temp"]["max"]} with #{day["weather"][0]["description"]}"
        day_number = day_number + 1
end

@fiveday = loopie[2,3]



  url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=44280fe520604217853468d445b056a3"
    @news = HTTParty.get(url).parsed_response.to_hash
    @todaysnews = @news["articles"][0, 5]

view 'news'

end 
