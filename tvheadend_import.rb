# encoding: UTF-8

require 'rubygems'
require 'open-uri'
require 'rest-client'

require_relative 'config.rb'

# Note: to debug RESTful calls use: RESTCLIENT_LOG=stdout ruby tvheadend_import.rb

channum = nil
name = nil
xmltv_id = nil
url = nil

open(A1TV_SOURCE_M3U_FILE_URL) {|f|
  f.each_line { |line|
    # mythtv is not very tolerant with it's m3u files, it doesn't like empty lines
    next if line.strip.empty?
    
    if /^#EXTINF:.*tvg-num="([^"]*)".*,(.*)/ =~ line
      channum = $1
      name = $2
      xmltv_id = CHANNEL_TABLE[name]
      
    elsif /^(rtp:\/\/.*)/ =~ line
      url = $1
      puts "Configuring: #{channum} #{name} #{xmltv_id} #{url}"
      if xmltv_id == nil
        print "Warning: No xmltv id for channel - ", name, "\n"
      end
      
      # create a Mux using the RESTful JSON API
      RestClient.post TVHEADEND_BASE_URL+"/api/mpegts/network/mux_create", :uuid => TVHEADEND_NETWORK_UUID,
        :conf => {"enabled"=>true, "iptv_url"=>url, "iptv_muxname"=>name}.to_json

    end
  }
}
