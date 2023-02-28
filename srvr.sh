# CODE MODDED BY T0MCAT :):):)

#!/bin/bash
syncweb="false"
syncjars="true"
emergbukkit="false"
eagurl="https://raw.githubusercontent.com/LAX1DUDE/eaglercraft/main/stable-download/stable-download_repl.zip"
echo Closing old server...
nginx -s stop -c ~/$REPL_SLUG/nginx.conf -g 'daemon off; pid /tmp/nginx/nginx.pid;' -p /tmp/nginx -e /tmp/nginx/error.log
pkill java
pkill nginx
rm -rf /tmp/*
echo Checking files...
status_code=$(curl -L --write-out %{http_code} --silent --output /dev/null "$eagurl")
if [[ "$status_code" -ne 200 ]] ; then
  syncweb="false"
  syncjars="false"
else
  echo site is still up! downloading...
  curl -L -o stable-download.zip "$eagurl"
  echo extracting zip...
  mkdir /tmp/new
  cd /tmp/new
  jar xvf $HOME/$REPL_SLUG/stable-download.zip
  cd $HOME/$REPL_SLUG
  echo deleting original zip file...
  rm -rf stable-download.zip
  mkdir web
  mkdir java
  mkdir java/bungee_command
  mkdir java/bukkit_command
  if [ "$syncweb" = "true" ]; then
    echo updating web folder...
    rm -rf web/*
    cp -r /tmp/new/web/. ./web/
    echo backing up original index.html file...
    cp web/index.html web/index.html.ORIG
  fi
  if [ "$syncjars" = "true" ]; then
    echo updating bungeecord server...
    if [ -f "updated.yet" ]; then
      rm -f java/bungee_command/bungee-dist.jar
      cp /tmp/new/java/bungee_command/bungee-dist.jar ./java/bungee_command/
    else
      rm -rf java/bungee_command/*
      cp -r /tmp/new/java/bungee_command/. ./java/bungee_command/
      echo ensuring that bungeecord is hosting on the correct port...
      sed -i 's/host: 0\.0\.0\.0:[0-9]\+/host: 127.0.0.1:1/' java/bungee_command/config.yml
      sed -i 's/^server-ip=$/server-ip=127.0.0.1/' java/bukkit_command/server.properties
    fi
    echo updating bukkit server...
    if [ "$emergbukkit" = "true" ]; then
      rm -rf java/bukkit_command/*
      cp -r /tmp/new/java/bukkit_command/. ./java/bukkit_command/
    else
      rm -f java/bukkit_command/craftbukkit-1.5.2-R1.0.jar
      cp /tmp/new/java/bukkit_command/craftbukkit-1.5.2-R1.0.jar ./java/bukkit_command/
    fi
  fi
  echo removing update data...
  rm -rf /tmp/new
  echo deleting old directory if it exists for some reason...
  rm -rf old
fi
echo Starting BungeeCord...
cd java/bungee_command
tmux new -d -s bungee java -Xmx32M -Xms32M -jar bungee-dist.jar
cd -
echo Starting NGINX...
mkdir /tmp/nginx
nginx -c ~/$REPL_SLUG/nginx.conf -g 'daemon off; pid /tmp/nginx/nginx.pid;' -p /tmp/nginx -e /tmp/nginx/error.log > /tmp/nginx/output.log 2>&1 &
if [ -f "default_server" ] && ! { [ "$REPL_OWNER" == "T0MCAT" ] && [ "$REPL_SLUG" == "TomcatTEC" ]; };
then
  echo Resetting world...
  rm default_server
  rm -rf java/bukkit_command/world
  rm -rf java/bukkit_command/world_nether
  rm -rf java/bukkit_command/world_the_end
  rm -f java/bukkit_command/server.log.lck
  rm java/bukkit_command/server.log
  rm -f java/bungee_command/proxy.log.0.lck
  rm java/bungee_command/proxy.log.0
fi
echo Starting Bukkit...
cd java/bukkit_command
java -Xmx512M -Xms512M -jar craftbukkit-1.5.2-R1.0.jar
cd -
echo Killing BungeeCord and NGINX...
nginx -s stop -c ~/$REPL_SLUG/nginx.conf -g 'daemon off; pid /tmp/nginx/nginx.pid;' -p /tmp/nginx -e /tmp/nginx/error.log
pkill java
pkill nginx
echo Done!

# CODE MODDED BY T0MCAT :):):)