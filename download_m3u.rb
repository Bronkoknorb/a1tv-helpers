# encoding: UTF-8

# Downloads all the m3u files from A1 to local files

require 'open-uri'

download = URI.open('http://epggw.a1.net/a/service.fta.m3u')
IO.copy_stream(download, 'm3u/A1-TV_basic.m3u')

download = URI.open('http://epggw.a1.net/a/service.plus.m3u')
IO.copy_stream(download, 'm3u/A1-TV_plus.m3u')

download = URI.open('http://epggw.a1.net/a/service.m3u')
IO.copy_stream(download, 'm3u/A1-TV_all.m3u')

download = URI.open('http://epggw.a1.net/a/service.radio.m3u')
IO.copy_stream(download, 'm3u/A1-TV_radio.m3u')
