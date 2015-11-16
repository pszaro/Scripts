#
# Description: Turns Spotlight Indexing Off
#
sudo mdutil -a -i off

growlnotify --appIcon Xcode System -m 'MacPro: Indexing Turned Off! ' -i Terminal -s
