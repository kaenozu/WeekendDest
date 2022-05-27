class DrivingController < ApplicationController
  def index
    p 'index start'
  end

  def list
    p 'list start'
    return if params[:src].nil?

    geoReq = Api::GoogleGeo::Request.new
    geoRes = geoReq.request(params[:src])

    routeRequest = Api::GoogleRoute::Request.new
    route = []
    randomList = []
    Tourist.all.each do |s|
      distance = Tourist.distance(geoRes['result']['latitude'], geoRes['result']['longitude'], s['latitude'].to_f,
                                  s['longitude'].to_f)
      # distance = Tourist.distance(params[:src].split(",")[0].to_f, params[:src].split(",")[1].to_f, s["latitude"].to_f, s["longitude"].to_f)
      if distance < 100
        randomList.push({ src: params[:src], dest: s['latitude'] + ',' + s['longitude'], place_name: s['place_name'] })
      end
    end
    @srcdestMap = randomList.sample
    route.push(@srcdestMap)

    routeRes = routeRequest.request(route)

    unless routeRes.nil?
      # 返却した値はそのまま画面へ
      @result = routeRes['result']
    end

    render :list
  end
end
