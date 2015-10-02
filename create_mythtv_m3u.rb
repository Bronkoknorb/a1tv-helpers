# encoding: UTF-8

require 'open-uri'

require_relative 'config.rb'

open(A1TV_SOURCE_M3U_FILE_URL) {|f|
  f.each_line { |line|
    # mythtv is not very tolerant with it's m3u files, it doesn't like empty lines
    next if line.strip.empty?
    
    if /^#EXTINF:.*tvg-num="([^"]*)".*,(.*)/ =~ line
      channum = $1
      name = $2
      
      print "#EXTINF:0,", channum, " - ",name, "\n"
      
      xmltv_id = CHANNEL_TABLE[name]
      
      if xmltv_id != nil
        print "#EXTMYTHTV:xmltvid=", xmltv_id, "\n"
      else
        $stderr.print "Warning: No xmltv id for channel - ", name, "\n"
      end
    else
      print line
    end
  }
}
