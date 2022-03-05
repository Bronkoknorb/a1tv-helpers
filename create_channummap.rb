# encoding: UTF-8

require 'rubygems'
require 'open-uri'
require 'json'

require_relative 'config.rb'

channum_map = {}

URI.open(A1TV_SOURCE_M3U_FILE_URL) {|f|
  f.each_line { |line|

    if /^#EXTINF:.*tvg-num="([^"]*)".*,(.*)/ =~ line
      channum = $1.to_i
      name = $2
      
      channum_map[name] = channum
    end
  }
}

puts JSON.pretty_generate(channum_map)
