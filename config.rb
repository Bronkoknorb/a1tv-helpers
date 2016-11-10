# encoding: UTF-8

# Configuration

# Source m3u file for A1 TV channels
# http://epggw.a1.net/ will list available m3u files
A1TV_SOURCE_M3U_FILE_URL = "http://epggw.a1.net/a/service.plus.m3u"

# Alternatively you can also use a local copy of an A1 m3u file (e.g. if
# the A1 site is not available). The git repository contains the m3u files,
# but the version from the A1 site will probably be more up-to-date.
# To use a local file comment the above A1TV_SOURCE_M3U_FILE_URL and
# uncomment and adapt the next line:
#A1TV_SOURCE_M3U_FILE_URL = "m3u/A1-TV_plus.m3u"

# URL of tvheadend web user interface
# (Username and password need to be added when public access is not allowed:
#  e.g.: "http://user:pwd@localhost:9981" )
TVHEADEND_BASE_URL = "http://localhost:9981"

# UUID of the A1 TV Network created within TVHeadend.
# The network needs to be manually created before using the tvheadend_import.rb
# script. Please see README for details.
TVHEADEND_NETWORK_UUID = "b46f6b35d6823d227644add3ee071eee"

# Mapping of channel names to XMLTV channel ids.
# (Source for xmltv.se XMLTV Channel IDs:
#  http://xmltv.xmltv.se/channels-Austria.xml.gz )
CHANNEL_TABLE = {
  "ORFeins" => "orf1.orf.at",
  "ORF eins" => "orf1.orf.at",
  "ORFeins HD" => "orf1.orf.at",
  "ORF 2 W" => "orf2.orf.at",
  "ATV" => "atv.at",
  "ATVplus" => "atv.at",
  "PULS4" => "puls4.at",
  "PULS 4" => "puls4.at",
  "ServusTV" => "servustv.com",
  "Servus TV Oesterreich" => "servustv.com",
  "ServusTV HD" => "servustv.com",
  "Sat.1 Austria" => "sat1.de",
  "Sat.1 Oesterreich" => "sat1.de",
  "ProSieben Austria" => "prosieben.de",
  "Pro7 Oesterreich" => "prosieben.de",
  "kabel eins Austria" => "kabel1.de",
  "Kabel1 Oesterreich" => "kabel1.de",
  "RTL Austria" => "rtl.de",
  "RTL Oesterreich" => "rtl.de",
  "VOX Austria" => "vox.de",
  "VOX Oesterreich" => "vox.de",
  "sixx Austria" => "sixx.de",
  "Sixx Austria" => "sixx.de",
  "RTL2 Austria" => "rtl2.de",
  "RTL II Oesterreich" => "rtl2.de",
  "ATV//" => "atv2.at",
  "ATV2" => "atv2.at",
  "Sat.1 Gold" => "gold.sat1.de",
  "Sat 1 Gold Oesterreich" => "gold.sat1.de",
  "ProSieben Maxx" => "maxx.prosieben.de",
  "ProSieben Maxx Austria" => "maxx.prosieben.de",
  "RTL Nitro" => "nitro.rtl.de",
  "Das Erste" => "daserste.de",
  "Das Erste HD" => "daserste.de",
  "ZDF" => "zdf.de",
  "ZDF HD" => "zdf.de",
  "SRF 1" => "sf1.srf.ch",
  "SF 1" => "sf1.srf.ch",
  "SRF zwei" => "sf2.srf.ch",
  "SF 2" => "sf2.srf.ch",
  "SF ZWEI" => "sf2.srf.ch",
  "ORF III" => "orf3.orf.at",
  "ORF 3" => "orf3.orf.at",
  "ORF III HD" => "orf3.orf.at",
  "3sat" => "3sat.de",
  "3sat HD" => "3sat.de",
  "arte" => "arte.de",
  "DMAX" => "dmax.discovery.de",
  "DMAX Austria" => "dmax.discovery.de",
  "ORF SPORT +" => "sportplus.orf.at",
  "ORF SPORT+" => "sportplus.orf.at",
  "SuperRTL" => "super.rtl.de",
  "Super RTL Oesterreich" => "super.rtl.de",
  "KIKA" => "kika.daserste.de",
  "KI.KA" => "kika.daserste.de",
  "KI.KA HD" => "kika.daserste.de",
  "nickelodeon" => "nick.de",
  "Nickelodeon" => "nick.de",
  "Disney Channel" => "disneychannel.de",
  "CC/VIVA AT" => "comedycentral.de",
  "Viva Austria" => "comedycentral.de",
  "n-tv" => "n-tv.de",
  "CNN international" => "cnn.com",
  "CNN International" => "cnn.com",
  "zdf_neo" => "neo.zdf.de",
  "ZDF neo" => "neo.zdf.de",
  "ZDF Neo HD" => "neo.zdf.de",
  "ZDFinfo" => "infokanal.zdf.de",
  "ZDF Infokanal" => "infokanal.zdf.de",
  "zdf.kultur" => "kultur.zdf.de",
  "ZDF Kultur" => "kultur.zdf.de",
  "ZDF Kultur HD" => "kultur.zdf.de",
  "phoenix" => "phoenix.daserste.de",
  "Phoenix" => "phoenix.daserste.de",
  "Phoenix HD" => "phoenix.daserste.de",
  "EinsPlus" => "einsplus.daserste.de",
  "Eins Plus HD" => "einsplus.daserste.de",
  "tagesschau24" => "einsextra.daserste.de",
  "Tagesschau 24" => "einsextra.daserste.de",
  "einsfestival" => "einsfestival.daserste.de",
  "EinsFestival" => "einsfestival.daserste.de",
  "Eins Festival HD" => "einsfestival.daserste.de",
  "ARD alpha" => "br-alpha.daserste.de",
  "Tele 5" => "tele5.de",
  "SWR BW" => "bw.swr.daserste.de",
  "mdr" => "mdr.daserste.de",
  "MDR" => "mdr.daserste.de",
  "MDR HD" => "mdr.daserste.de",
  "NDR" => "ndr.daserste.de",
  "NDR HH HD" => "ndr.daserste.de",
  "WDR" => "wdr.daserste.de",
  "hr" => "hr.daserste.de",
  "hr HD" => "hr.daserste.de",
  "rbb" => "rbb.daserste.de",
  "SR" => "sr.swr.daserste.de",
  "SWR" => "sr.swr.daserste.de",
  "BBC World News" => "bbcworldnews.com",
  "BBC entertainment" => "bbcentertainment.eu",
  "BBC Entertainment" => "bbcentertainment.eu",
  "Euronews" => "euronews.com",
  "EuroNews" => "euronews.com",
  "Al Jazeera" => "aljazeera.net",
  "TV5 Monde Europe" => "tv5monde.org",
  "TV5" => "tv5monde.org",
  "France24" => "france24.com",
  "France 24" => "france24.com",
  "Channel One Russia" => "1tvrus.com",
  "Ö3 Visual Radio" => "oe3.radio.orf.at",
  "FashionTV" => "ftv.com",
  "Fashion TV" => "ftv.com",
  "TLC" => "tlc.discovery.de",
  "BibelTV" => "bibeltv.de",
  "Bibel TV" => "bibeltv.de",
  "Rai Uno" => "tv1.rai.it",
  "Rai uno" => "tv1.rai.it",
  "Rai Due" => "tv2.rai.it",
  "Rai due" => "tv2.rai.it",
  "Rai Tre" => "tv3.rai.it",
  "Rai tre" => "tv3.rai.it",
}
