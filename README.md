a1tv-helpers
============

This is a collection of scripts for importing channels of Austrian IPTV [A1 TV](http://www.a1.net/tv/) into [MythTV](https://www.mythtv.org/) and [Tvheadend](http://tvheadend.org/) (for use as a [PVR backend within Kodi](http://kodi.wiki/view/Tvheadend_PVR), which was formerly known as XBMC).

Prerequisites
-------------

Install ruby and required libraries:

    sudo apt-get install ruby ruby-dev
    sudo gem install rest-client

create_mythtv_m3u.rb
--------------------

This will convert the A1 TV channel list to a m3u file suitable for import into MythTV.

TBD

tvheadend_import.rb
-------------------

This will import A1 TV channels as "Muxes" into Tvheadend.

TBD
