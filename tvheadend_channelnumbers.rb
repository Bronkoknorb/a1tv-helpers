# encoding: UTF-8

require 'rubygems'
require 'rest-client'
require 'json'

require_relative 'config.rb'
require_relative 'tvheadend_common.rb'

unless ARGV.length == 1
  puts "Error: Expecting one argument."
  puts "Usage: ruby tvheadend_channelnumbers.rb channummap.json"
  exit
end

channum_map_filecontent = File.read(ARGV[0])
channum_map = JSON.parse(channum_map_filecontent)

tvheadend_channels_each { |channel|

  channel_name = channel["name"]

  channum = channum_map[channel_name]
  
  if channum == nil

    # name of channel not found in table, try with name of mux instead
    mux_name = tvheadend_get_mux_name_for_channel(channel)
    channum = channum_map[mux_name]

    if channum == nil
      puts "Warning: No channel number associated with channel #{channel_name} / #{mux_name}"
      next
    end
  
  end
  
  puts "#{channel_name} -> #{channum}"
  channel["number"] = channum
  
  tvheadend_save_channel(channel)

}
