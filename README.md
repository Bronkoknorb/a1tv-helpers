a1tv-helpers
============

This is a collection of scripts for importing channels of Austrian IPTV
[A1 TV](https://www.a1.net/tv/s/tv-uebersicht) (a.k.a. A1 Xplore TV) into [MythTV](https://www.mythtv.org/) and
[Tvheadend](http://tvheadend.org/).

As Tvheadend can be used as a [PVR backend for Kodi](http://kodi.wiki/view/Tvheadend_PVR), these scripts enable to watch and record A1 TV within Kodi. [Kodi](http://kodi.tv/) (formerly
known as XBMC) is a popular Media Center software for Linux, Windows and Android and it is also used as the media player within
[OSMC](http://osmc.tv/) (the successor of Raspbmc),
[LibreELEC](https://libreelec.tv/), [OpenELEC](http://openelec.tv/),
[XBian](http://www.xbian.org/) and more. All of them can be run on a
[Raspberry Pi](https://en.wikipedia.org/wiki/Raspberry_Pi).

Personally I currently use a Raspberry Pi 4 with Raspbian Stretch, Kodi and Tvheadend to watch and record A1 TV and it works really well. Before that I used a Media Center PC with MythTV, but development of MythTV seems to progress only slowly, so I wouldn't recommend it any more.

Source: https://github.com/Bronkoknorb/a1tv-helpers

Prerequisites
-------------

This README assumes you are using Debian/Raspbian or some derivative like Ubuntu.

Install ruby and required libraries:

    sudo apt-get install ruby ruby-dev
    sudo gem install rest-client
    
If the second command fails with *"ERROR: Failed to build gem native extension."*, it should help to install make and build-essentials first:

    sudo apt-get install make build-essentials

Compatibility
-------------

These scripts have been tested with the following versions:

* Tvheadend version 4.0, 4.1 and 4.2
* Kodi version 16 and 17
* MythTV version 0.27

Overview
--------

* [`create_mythtv_m3u.rb`](#create_mythtv_m3urb) - Convert A1 TV channel list to
  an m3u file compatible with MythTV
* [`tvheadend_import.rb`](#tvheadend_importrb) - Import A1 TV channels into
  Tvheadend (for viewing them in Kodi)
* [`tvheadend_channelnumbers.rb`](#tvheadend_channelnumbersrb) - Setup channel
  numbers in Tvheadend (and Kodi)
* [`create_channummap.rb`](#create_channummaprb) - Create default channel numbers
  for A1 TV channels
* [`tvheadend_xmltv.rb`](#tvheadend_xmltvrb) - Setup XMLTV IDs with channels so
  that EPG data is available in Tvheadend (and Kodi)

create_mythtv_m3u.rb
--------------------

A1 offers up-to-date channel lists in m3u file format at
[epggw.a1.net](http://epggw.a1.net/). Unfortunately the m3u format from A1 is
not directly compatible with MythTV. This script will convert the A1 TV channel
list to a m3u file suitable for import into MythTV.

Configuration: Please adapt the following configuration values within
`config.rb`:
  * `A1TV_SOURCE_M3U_FILE_URL`: The source m3u file from A1
  * `CHANNEL_TABLE`: Used for mapping channel names to XMLTV IDs (for
     associating EPG data)

Usage:

    ruby create_mythtv_m3u.rb > channels.m3u

You can import the generated m3u file using the MythTV Backend Setup.


tvheadend_import.rb
-------------------

This script will import A1 TV channels as *Muxes* into Tvheadend (using its
RESTful JSON API).

First you will need to create a *Network* within the configuration of Tvheadend:
Open the Web UI of Tvheadend (typically `http://localhost:9981`) and go to
*Configuration -> DVB Inputs -> Networks*. Click *Add* and select *IPTV Network*
as type. Set the *Network name* to "A1 TV". Make sure to also set a value for
*Max Input Streams*: It's the number of streams that A1 allows you to watch in
parallel (typically just 1). For the other settings the default values should be
okay.

After creating the new *Network* you will need to find out its unique
identifier (UUID). As this does not seem to be possible within the Web UI,
you'll have to look it up in the file system:

    sudo ls /home/hts/.hts/tvheadend/input/iptv/networks/
    
This assumes that your Tvheadend runs as the user *hts* (default in Ubuntu). The
UUID is an arbitrary string of letters and numbers,
e.g. "b46f6b35d6823d227644add3ee071eee".

Configuration: Please adapt the following configuration values within
`config.rb`:
  * `A1TV_SOURCE_M3U_FILE_URL`: The source m3u file from A1
  * `TVHEADEND_BASE_URL`: Base URL of the Tvheadend Web UI
  * `TVHEADEND_NETWORK_UUID`: Needs to be set to the UUID of the Network created
    before

Usage:

    ruby tvheadend_import.rb
    
After the script has executed successfully, go to the configuration Web UI of
Tvheadend again: *Configuration -> DVB Inputs -> Muxes* should contain a *Mux*
for each channel. Tvheadend now needs to gather data about each Mux. You will
have to wait until the *Scan Result* is *OK* and the *Scan Status* is *IDLE* for
every Mux. This will take quite some time.

If some Muxes get a *Scan Result* of *FAIL*, TVHeadend couldn't successfully
open the stream. In that case you can try to force a retry by setting the
*Scan Status* to *PEND* (pending) again.

For each Mux with an *OK* status, there should now also be a *Service* under
*Services*. That is still not enough :-) - you will then need to map each
service to a *Channel*:

Go to *Configuration -> Channel / EPG* and click on
*Map Services*. Now the channel list should fill up automatically with all
A1 TV channels.

For watching these channels in Kodi (XBMC) please refer to:
http://kodi.wiki/view/Tvheadend_PVR


tvheadend_channelnumbers.rb
---------------------------

This script will set up the channel numbers in Tvheadend by using a given
`channummap.json` file that maps channel names (resp. Mux names) to channel
numbers. The file `channummap_example.json` contains a sample mapping.
The script [`create_channummap.rb`](#create_channummaprb) (as described below) can be used to
automatically create such a `channummap.json` file for A1 TV.

Configuration:
  * A `channumap.json` file has to be created first.
  * Please adapt the following configuration values within `config.rb`:
    * `TVHEADEND_BASE_URL`: Base URL of the Tvheadend Web UI

Usage:
    
    ruby tvheadend_channelnumbers.rb channummap.json


create_channummap.rb
--------------------

This script will automatically create a `channummap.json` file based on the
channel numbers as defined by an m3u channel list offered by A1. The resulting
file can be used as input for the
[`tvheadend_channelnumbers.rb`](#tvheadend_channelnumbersrb) script described
above. It can be used as is, or can be manually adapted to change the channel
numbers.

Configuration: Please adapt the following configuration values within
`config.rb`:
  * `A1TV_SOURCE_M3U_FILE_URL`: The source m3u file from A1

Usage:

    ruby create_channummap.rb > channummap.json

tvheadend_xmltv.rb
------------------

This script will associate XMLTV IDs with the channels defined in Tvheadend so
that EPG (electronic program guide) data can be automatically fetched.

You will first have to correctly set up XMLTV grabbing within Tvheadend.
Currently the free data supplied by xmltv.se works quite well with A1 TV. Most
of Austrian channels are available.

Update: Unfortunately xmltv.se is no longer freely available. An alternative source
is described in the next section.

Install XMLTV utilities if you do not already have them:

    sudo apt-get install xmltv-util

This should also include the grabber `tv_grab_eu_xmltvse` which is compatible with
xmltv.se.
To configure this grabber for use within Tvheadend first log in as the user
which runs Tvheadend (defaults to *hts* in Ubuntu):

    sudo su hts

Then configure the grabber:

    tv_grab_eu_xmltvse --configure

You will be asked some questions: Set the *Root URL for grabbing data* to
*http://xmltv.xmltv.se/channels-Austria.xml.gz* (for Austrian channels). The
*Directory to store the cache in* can stay on the default
(*/home/hts/.xmltv/cache*). Simply select *all* channels.

Afterwards the grabber needs to be activated in Tvheadend. If you just installed
the XMLTV utilities, you will have to restart Tvheadend:

    sudo service tvheadend restart

Next, go to the Web UI and open *Configuration -> Channel / EPG -> EPG Grabber*:
Under *Internal Grabber* select *XMLTV: Sweden (TVZon)* and save the
configuration.
You will then need to ensure that Tvheadend runs the grabber at least once. The
*Cron multi-line* property controls how often the grabber is run. You can either
wait for the configured time to pass or set it temporarily to the next minute
(e.g. set it to `53 19 * * *` if the time is currently 19:52). Then wait a few
minutes for the grabber to finish. In newer versions if tvheadend you can simply
click on "Re-run internal EPG grabbers" to run it immediately.

If everything worked out fine, you should then be able to associate XMLTV IDs
with the channels. Go to *Configuration -> Channel / EPG -> Channels* select one
of the channels, click *Edit* and choose one of the available sources in the
*EPG source* drop down menu.

It's boring to manually set this for every channel and this is where the script
`tvheadend_xmltv.rb` comes to rescue:

Configuration: Please adapt the following configuration values within
`config.rb`:
  * `CHANNEL_TABLE`: Used for mapping channel names to XMLTV IDs. You will have
     to manually update this when new channels get added to A1 TV.

Usage:

    ruby tvheadend_xmltv.rb

After the script has executed successfully, each channel should be associated
with an EPG source. Open *Configuration -> Channel / EPG -> Channels* to verify
that. The next time the grabber is run by Tvheadend the EPG data should get
populated. (Note: Of course you can again force a run of the grabber with
the trick described above.) :-)

tv_grab_a1tv.sh
---------------

Luckily a member of the A1 Community provides EPG (electronic program guide) in XMLTV format data at https://a1.epg.wb1.xyz/

This simple script downloads the data and can be used directly as a XMLTV grabber by Tvheadend.

Install XMLTV utilities if you do not already have them:

    sudo apt-get install xmltv-util

Tvheadend uses the program `tv_find_grabbers` to find available grabbers.
For this tool to find our script, it needs to be copied (or symlinked) to /usr/bin/tv_grab_a1tv:

    sudo ln -s "$(pwd)/tv_grab_a1tv.sh" /usr/bin/tv_grab_a1tv

Next, go to the Web UI and open *Configuration -> Channel / EPG -> EPG Grabber*:
Under *Internal Grabber* select *XMLTV: A1 TV*, activate it, and save the
configuration.
Click "Re-run internal EPG grabbers" to run the grabber. Check the log at the bottom of the page.

If everything worked out fine, you should then be able to associate XMLTV IDs
with the channels. Go to *Configuration -> Channel / EPG -> Channels* select one
of the channels, click *Edit* and choose one of the available sources in the
*EPG source* drop down menu.

Then run the grabber again, and it should download the EPG data and associate it with the channels.


Questions / Contributions
-------------------------

If you have problems or questions then please
[open an Issue on github](https://github.com/Bronkoknorb/a1tv-helpers/issues).

Feel free to fork the repository and create pull requests for improvements and
additional scripts.

Author
------

Hermann Czedik-Eysenberg  
a1tv-helpers@hermann.czedik.net
