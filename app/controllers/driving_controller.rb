class DrivingController < ApplicationController
  def index
    p "index start"
  end

  def list
    p "list start"
    p "params[:src]:" + params[:src]
    if params[:src].present?
      # cash確認
      srcGeoCashEntity = SrcGeoCash.find_by(place_name: params[:src])
      if srcGeoCashEntity.nil?
        geoReq = Api::GoogleGeo::Request.new
        geoRes = geoReq.request(params[:src])
        SrcGeoCash.create(
          place_name: params[:src],
          latitude: geoRes["result"]["latitude"],
          longitude: geoRes["result"]["longitude"],
        )
      else
        p "geocash found"
        geoRes = { "result" => { "latitude" => srcGeoCashEntity.latitude, "longitude" => srcGeoCashEntity.longitude } }
      end

      routeRequest = Api::GoogleRoute::Request.new
      route = []
      randomList = []
      @result = []
      @srcdestMap = {}
      Tourist.all.each do |s|
        distance = Tourist.distance(geoRes["result"]["latitude"], geoRes["result"]["longitude"], s["latitude"].to_f,
                                    s["longitude"].to_f)
        if distance < 100
          randomList.push({ src: params[:src], dest: s["latitude"] + "," + s["longitude"], place_name: s["place_name"] })
        end
      end
      if !randomList.empty?
        @srcdestMap = randomList.sample
        # cash確認
        routeCashEntity = RouteCash.find_by(src: @srcdestMap[:src], dest: @srcdestMap[:dest])
        if routeCashEntity.nil?
          route.push(@srcdestMap)
          routeRes = routeRequest.request(route)
          RouteCash.create(
            src: geoRes["result"]["latitude"].to_s + "," + geoRes["result"]["longitude"].to_s,
            dest: @srcdestMap[:dest],
            highway: routeRes["result"][0]["distance"]["highway"],
            localway: routeRes["result"][0]["distance"]["localway"],
          )
        else
          p "geocash found"
          routeRes = { "result" => { "location" => { "src" => @srcdestMap[:src], "dest" => @srcdestMap[:dest] }, "distance" => { "highway" => routeCashEntity.highway, "localway" => routeCashEntity.localway } } }
        end

        # 返却した値はそのまま画面へ
        @result = routeRes["result"]
      end

      render :list
    else
      redirect_to action: :index
    end
  end
end
