# Left 4 Dead 2 Server Docker Image

## Quickstart

### Ports
By default, you'll want to allow both incoming TCP and UDP traffic on port 27015. 

`docker run -p 27015:27015/tcp -p 27015:27015/udp --name l4d2 left4devops/l4d2`

#### Changing the port
To change the port used inside the container change the `PORT` environment variable, then map the new ports instead.

### Hostname
This identifies your server in the server browser.  By default it is set to "Left4DevOps".  Change it by setting the `HOSTNAME` environment variable.

e.g. To change your hostname to BILLS HERE:

`docker run -e HOSTNAME="BILLS HERE"`...

### Region
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

e.g. If your server was in Europe:

`docker run -e REGION=3`...

## Joining a game
There are a couple of ways you can achieve this:
* Start a lobby, then as host, open the developer console and type `mm_dedicated_force_servers [ip:port]`. This will try to use your server when the gae starts.
* Add the server as a favourite using the serverbrowser `openserverbrowser` in game. This will make it appear as a steam group server in the menu.
* 

## Advanced Tips

### Custom Addons
If you wanted to play a custom campaign on your server, you can mount a directory with any custom content into the `/home/louis/l4d2/left4dead2/addons/` directory.

e.g. If your working directory had a addons folder:

`docker run -v addons:/home/louis/l4d2/left4dead2/addons/`...

### Alternate command line options
Any commands sent to the docker will replace the default commands line options for `./srcds_run`

e.g. `docker run left4devops/l4d2 -port 27020 +map "c14m1_junkyard" +sv_lan 1` will execute `./srcds_run -port 27020 +map "c14m1_junkyard" +sv_lan 1` 

### Custom Config
You can skip the config created by environment vars by mounting in your own server.cfg

e.g. `docker run -v server.cfg:/home/louis/l4d2/left4dead2/cfg/server.cfg`...

### RCON
Set an RCON password using the `RCON_PASSWORD` environment variable.  Make sure it's hard to guess or others will control your server!