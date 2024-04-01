# Left 4 Dead 2 Dedicated Server Docker Image

This repository can be used to build Left 4 Dead 1 + 2 as separate images.

## Quickstart
By default, you'll want to allow both incoming TCP and UDP traffic on port 27015.

`docker run -p 27015:27015/tcp -p 27015:27015/udp --name l4d2 --cap-add=NET_ADMIN left4devops/l4d2`

## Environment Variables
### PORT
Changes the port used inside the container, make sure your expose the new ports instead.

e.g `docker run -e PORT=27016 -p 27016:27016/tcp -p 27016:27016/udp --name l4d2 left4devops/l4d2`

### HOSTNAME
This identifies your server in the server browser.  By default, it is set to "Left4DevOps".

e.g. To change your hostname to **BILLS HERE** - `docker run -e HOSTNAME="BILLS HERE"`...

### REGION
To help hint to Steam where your server is located, set the `REGION` environment variable as one of the following numeric regions:

| Location        | REGION |
|-----------------|--------|
| East Coast USA  | 0      |
| West Coast USA  | 1      |
| South America   | 2      |
| Europe          | 3      |
| Asia            | 4      |
| Australia       | 5      |
| Middle East     | 6      |
| Africa          | 7      |
| World (Default) | 255    |

e.g. If your server was in Europe - `docker run -e REGION=3`...

### STEAM_GROUP
Make your server easier to join by providing the ID of your Steam Group as shown on the admin page. You can also set `STEAM_GROUP_EXCLUSIVE=true` to reduce the chances of your server being used by other people.

### RCON_PASSWORD
If you would like to remote control the server without using SourceMod, set an RCON password using the `RCON_PASSWORD` environment variable. Once you are connected to the server, use the developer console to set `rcon_password` and then `rcon`.

#### WARNING
* Make sure your RCON passsword is hard to guess or others will control your server!
* If using the default docker bridge networking, docker will not see the IP address of the client, and may ban the bridge IP.

## Custom Config
You can skip the config created by environment vars by mounting in your own server.cfg

e.g. `docker run -v server.cfg:/cfg/server.cfg`...

## Custom Addons
If you wanted to play a custom campaign on your server, or include sourcemod, you can mount a directory with any custom content into the `/home/louis/l4d2/left4dead2/addons/` directory.

e.g. If your working directory had a addons folder:

`docker run -v $pwd/addons:/addons/`...

## Joining a game
There are a couple of ways you can achieve this:
* Start a lobby, then as host, open the developer console and type `mm_dedicated_force_servers [ip:port]`. This will try to use your server when the game starts.
* Using the developer console, you can connect directly to the server `connect [ip:port]`
* Add the server as a favourite using the server browser `openserverbrowser` in game. This will make it appear as a steam group server in the menu.
* Set the `STEAM_GROUP` variable and choose to start the game from a Steam Group server in your lobby.

## Alternate command line options
Any commands sent to the docker will replace the default commands line options for `./srcds_run`

e.g. `docker run left4devops/l4d2 -port 27020 +map "c14m1_junkyard" +sv_lan 1` will execute `./srcds_run -port 27020 +map "c14m1_junkyard" +sv_lan 1`.