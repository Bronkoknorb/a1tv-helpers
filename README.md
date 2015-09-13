a1tv-helpers
============

This is a collection of scripts for importing channels of Austrian IPTV
[A1 TV](http://www.a1.net/tv/) into [MythTV](https://www.mythtv.org/) and
[Tvheadend](http://tvheadend.org/) (for use as a
[PVR backend within Kodi](http://kodi.wiki/view/Tvheadend_PVR), which was
formerly known as XBMC).

Source: https://github.com/Bronkoknorb/a1tv-helpers

Prerequisites
-------------

This README assumes you are using Ubuntu (or some derivative).

Install ruby and required libraries:

    sudo apt-get install ruby ruby-dev
    sudo gem install rest-client

create_mythtv_m3u.rb
--------------------

This script will convert the A1 TV channel list to a m3u file suitable for
import into MythTV.

Configuration: Please adapt the following configuration values within
`config.rb`:
  * `A1TV_SOURCE_M3U_FILE_URL`
  * `CHANNEL_TABLE`

Usage:

    ruby create_mythtv_m3u.rb > channels.m3u

You can then import the generated m3u file using the MythTV Backend Setup.
    
tvheadend_import.rb
-------------------

This script will import A1 TV channels as *Muxes* into Tvheadend (using its
RESTful JSON API).

First you will need to create a *Network* within the configuration of Tvheadend:
Open the Web UI of Tvheadend (typically `http://localhost:9981`) and go to
*Configuration -> DVB Inputs -> Networks*. Click *Add* and select *IPTV Network*
as type. Set the *Network name* to *A1 TV*. Make sure to also set a value for
*Max Input Streams*: It's the number of streams that A1 allows you to watch in
parallel (typically just 1). For the other settings the default values should be
okay. After creating the new *Network* you will need to find out its unique
identifier (UUID). As this does not seem to be possible within the Web UI,
you'll have to look it up in the file system:

    ls /home/hts/.hts/tvheadend/input/iptv/networks/
    
This assumes that your Tvheadend runs as the user *hts* (default in Ubuntu). The
UUID is an arbitry string of letters and numbers,
e.g. "b46f6b35d6823d227644add3ee071eee".

Configuration: Please adapt the following configuration values within
`config.rb`:
  * `A1TV_SOURCE_M3U_FILE_URL`
  * `TVHEADEND_BASE_URL`
  * `TVHEADEND_NETWORK_UUID` (needs to be set to the UUID of the Network created
    before)

Usage:

    ruby tvheadend_import.rb
    
After the script has executed successfully, go to the configuration Web UI of
Tvheadend again: *Configuration -> DVB Inputs -> Muxes* should contain a *Mux*
for each channel. Tvheadend now needs to gather data about each Mux. You will
have to wait until the *Scan Result* is *OK* and the *Scan Status* is *IDLE* for
every Mux. This will take quite some time. If some Muxes get a *Scan Result* of
*FAIL*, TVHeadend couldn't successfully open the stream. Then you can try to
force a retry by setting the *Scan Status* to *PEND* (pending) again.
For each Mux with an *OK* status, there should now also be a *Service* under
*Services*. That is still not enough :-) - you will then need to map each
service to a *Channel*: Go to *Configuration -> Channel / EPG* and click on
*Map Services*. The channel list should then fill up automatically with all
A1 TV channels.

For watching these channels in Kodi (XBMC) please refer to:
http://kodi.wiki/view/Tvheadend_PVR

TODO: describe the mapping to XMLTV ids.
