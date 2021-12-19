#!/bin/bash
# Update Game
./steamcmd.sh +login anonymous +force_install_dir ./l4d2 +app_update 222860 +quit

#Softlink l4d2 maps to addons folder
#It would more convenience while you want add custom map. Exspecially when you have sourcemod plugins
#you just need mount your extra map folder to docker container /map . 
ln  -s  /map/*  l4d2/left4dead2/addons/

# Server Config
if "$plugin"= "anna"; then
    git clone https://github.com/fantasylidong/AnneServer
    cp -r neko/* l4d2/
    
if "$plugin"= "hexo"; then
    git clone https://github.com/fantasylidong/neko.git
    cp -r neko/* l4d2/

# Start Game
cd l4d2 && ./srcds_run -console -game left4dead2 -port "$PORT" +maxplayers "$PLAYERS" +map "$MAP"
