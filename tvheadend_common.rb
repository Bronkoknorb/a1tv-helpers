# encoding: UTF-8

require 'rubygems'
require 'rest-client'
require 'json'

require_relative 'config.rb'

def tvheadend_channels_each

  # load all channels
  # TODO consider using /api/channel/list instead of /grid
  channels_grid = RestClient.get TVHEADEND_BASE_URL+'/api/channel/grid?limit=999999'
  channels_grid_parsed = JSON.parse(channels_grid)

  channels = channels_grid_parsed["entries"]
  
  channels.each { |channel|
    yield channel
  }

end

def tvheadend_save_channel(channel)
  RestClient.post TVHEADEND_BASE_URL+"/api/idnode/save", :node => channel.to_json
end

def tvheadend_get_mux_name_for_channel(channel)

  services = channel["services"]
  
  if services.size != 1
    puts "Error: Expecting one service for channel #{channel_name}, got #{services}"
    return nil
  end
  
  service_uuid = services[0]
  
  service_json = RestClient.get TVHEADEND_BASE_URL+'/api/idnode/load?uuid='+service_uuid
  service = JSON.parse(service_json)["entries"][0]

  service_params = service["params"]
  
  service_param_mux = service_params.select { |param| param["id"] == "multiplex" }[0]
  
  mux_name = service_param_mux["value"]

  return mux_name

end
