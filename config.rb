# encoding: UTF-8

# Configuration

# Source m3u file for A1 TV channels
# http://epggw.a1.net/ will list available m3u files
A1TV_SOURCE_M3U_FILE_URL = "http://epggw.a1.net/a/service.plus.m3u"

# URL of tvheadend web user interface
# (Username and password need to be added when public access is not allowed:
#  e.g.: "http://user:pwd@localhost:9981" )
TVHEADEND_BASE_URL = "http://localhost:9981"

# UUID of the A1 TV Network created within TVHeadend.
# The network needs to be manually created before using the tvheadend_import.rb
# script. Please see README for details.
TVHEADEND_NETWORK_UUID = "b46f6b35d6823d227644add3ee071eee"

# Mapping of channel names to XMLTV channel ids.
# Currently only used by create_mythtv_m3u.rb,
# not needed for tvheadend_import.rb
# (Source for xmltv.se XMLTV Channel IDs:
#  http://xmltv.xmltv.se/channels-Austria.xml.gz)
CHANNEL_TABLE = {
  "ORFeins" => "orf1.orf.at",
  "ORF 2 W" => "orf2.orf.at",
  "ATV" => "atv.at",
  "PULS4" => "puls4.at",
  "ServusTV" => "servustv.com",
  "Sat.1 Austria" => "sat1.de",
  "ProSieben Austria" => "prosieben.de",
  "kabel eins Austria" => "kabel1.de",
  "RTL Austria" => "rtl.de",
  "VOX Austria" => "vox.de",
  "sixx Austria" => "sixx.de",
  "RTL2 Austria" => "rtl2.de",
  "ATV//" => "atv2.at",
  "Sat.1 Gold" => "gold.sat1.de",
  "ProSieben Maxx" => "maxx.prosieben.de",
  "RTL Nitro" => "nitro.rtl.de",
  "Das Erste" => "daserste.de",
  "ZDF" => "zdf.de",
  "SRF 1" => "sf1.srf.ch",
  "SRF zwei" => "sf2.srf.ch",
  "ORF III" => "orf3.orf.at",
  "3sat" => "3sat.de",
  "arte" => "arte.de",
  "DMAX Austria" => "dmax.discovery.de",
  "ORF SPORT +" => "sportplus.orf.at",
  "SuperRTL" => "super.rtl.de",
  "KIKA" => "kika.daserste.de",
  "nickelodeon" => "nick.de",
  "Disney Channel" => "disneychannel.de",
  "CC/VIVA AT" => "comedycentral.de",
  "n-tv" => "n-tv.de",
  "CNN international" => "cnn.com",
  "zdf_neo" => "neo.zdf.de",
  "ZDFinfo" => "infokanal.zdf.de",
  "zdf.kultur" => "kultur.zdf.de",
  "phoenix" => "phoenix.daserste.de",
  "EinsPlus" => "einsplus.daserste.de",
  "tagesschau24" => "einsextra.daserste.de",
  "einsfestival" => "einsfestival.daserste.de",
  "ARD alpha" => "br-alpha.daserste.de",
  "Tele 5" => "tele5.de",
  "SWR BW" => "bw.swr.daserste.de",
  "mdr" => "mdr.daserste.de",
  "NDR" => "ndr.daserste.de",
  "WDR" => "wdr.daserste.de",
  "hr" => "hr.daserste.de",
  "rbb" => "rbb.daserste.de",
  "SR" => "sr.swr.daserste.de",
  "BBC World News" => "bbcworldnews.com",
  "BBC entertainment" => "bbcentertainment.eu",
  "Euronews" => "euronews.com",
  "Al Jazeera" => "aljazeera.net",
  "TV5 Monde Europe" => "tv5monde.org",
  "France24" => "france24.com",
  "Channel One Russia" => "1tvrus.com",
  "Ö3 Visual Radio" => "oe3.radio.orf.at",
  "FashionTV" => "ftv.com",
  "TLC" => "tlc.discovery.de",
  "BibelTV" => "bibeltv.de",
  "Rai Uno" => "tv1.rai.it",
  "Rai Due" => "tv2.rai.it",
  "Rai Tre" => "tv3.rai.it",
}