# encoding: UTF-8

require 'rubygems'
require 'rest-client'

require_relative 'config.rb'
require_relative 'tvheadend_common'

tvheadend_channels_each { |channel|
  name = channel["name"]
  
  xmltv_id = CHANNEL_TABLE[name]
  if xmltv_id != nil
    channel["epggrab"] = [ "xmltv|" + xmltv_id ]
    puts "#{name} -> #{xmltv_id}"
  
    tvheadend_save_channel(channel)
  else
    print "Warning: No xmltv id for channel - ", name, "\n"
  end
}
