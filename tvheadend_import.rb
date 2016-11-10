# encoding: UTF-8

require 'rubygems'
require 'open-uri'
require 'rest-client'
require 'json'

require_relative 'config.rb'

# Note: to debug RESTful calls use: RESTCLIENT_LOG=stdout ruby tvheadend_import.rb

channum = nil
name = nil
url = nil

open(A1TV_SOURCE_M3U_FILE_URL) {|f|
  f.each_line { |line|

    if /^#EXTINF:.*tvg-num="([^"]*)".*,(.*)/ =~ line
      channum = $1
      name = $2
    elsif /^(rtp:\/\/.*)/ =~ line
      url = $1
      puts "Configuring: #{channum} #{name} #{url}"
      
      # create a Mux using the RESTful JSON API
      RestClient.post TVHEADEND_BASE_URL+"/api/mpegts/network/mux_create", :uuid => TVHEADEND_NETWORK_UUID,
        :conf => {"enabled"=>true, "iptv_url"=>url, "iptv_muxname"=>name}.to_json
    end
  }
}
