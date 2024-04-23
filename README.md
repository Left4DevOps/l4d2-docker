# Left 4 Dead / Left 4 Dead 2 Dedicated Server Docker Image

> "Oh, MAN! This is just like Counter-Strike!"

This repository can be used to build docker images for both Left 4 Dead and Left 4 Dead 2. You can use this repository
to build these images yourself, or pull them from our registry on [Docker Hub](https://hub.docker.com/u/left4devops).

## Getting Started

Running a vanilla server can as simple as running:

```shell
docker run --name l4d2 \
    --network host \
left4devops/l4d2
```

> [!IMPORTANT]
> The above example uses host networking (`--network host`), which is the preferred networking method, as it allows the 
> game server to correctly identify the IP of connecting players and can be used to ban players or anyone on the net 
> attempting to force access to RCON. To use host networking on windows or macOS, **enable host networking** from 
> [experimental features](https://docs.docker.com/network/network-tutorial-host/#prerequisites) in Docker version 4.29.

### Bridge Networking Mode
Although the game server won't be able to correctly identify player's IP correctly, you can use Docker's default bridge
networking mode instead. Ensure your game port is published using both the TCP and UDP protocols. 

```shell
docker run --name l4d2-bridged \
    -p 27015:27015/tcp \
    -p 27015:27015/udp \
left4devops/l4d2
```

### Restart behaviour

> "Someone needs to restart that generator!"

`srcds_run` includes a watchdog to restart the server process in the event of a crash. However, you may want to include
the `restart` parameter to ensure your server comes back up after a reboot, like so:

```shell
docker run --name l4d2-reboot \
    --restart unless-stopped \
left4devops/l4d2
```

### Denial of Service Protection

> "I hate elevators. I hate helicopters. I hate hospitals. And doctors and lawyers and cops..."

This section is in draft, see the [discussion here](https://github.com/Left4DevOps/l4d2-docker/issues/6) for more
detail.

## Joining a game

There are a couple of ways you can achieve this:

* Start a lobby, then as host, set the server type to **Best Available Dedicated**, open the developer console and
  type `mm_dedicated_force_servers [ip:port]`. This will try to use your server when the game starts.
* Set the `STEAM_GROUP` variable and choose to start the game from a Steam Group server in your lobby.
* Add the server as a favourite using the server browser `openserverbrowser` in game. This will make it appear as a
  steam group server in the menu.
* Using the developer console, you can connect directly to the server `connect [ip:port]`
* You can also open the Server Browser from steam under **View** > **Game Servers**.
* Servers on your LAN will be shown as Steam Group servers automatically

## Custom Addons

If you wanted to play a custom campaign on your server, or include sourcemod, you can mount a directory with any custom
content into the `/addons/` directory.

e.g. If your working directory had a addons folder:

```shell
docker run --name l4d2-server-addons \
    -v $(pwd)/addons:/addons/
left4devops/l4d2
```

## Configuration

### Environment Variables
You can pass environment variables to your Docker Container to configure a number of common settings.

#### HOSTNAME

This is the name of you server, as shown in the Server Browser and Steam Group Servers. Defaults to **Left4DevOps**.

To change your hostname to **BILLS HERE**:

```shell
docker run --name l4d2-hostname \
    -e HOSTNAME="BILLS HERE" \
left4devops/l4d2
```

#### REGION

> "I need every one of you inside, now!"

To help hint to Steam where your server is located, set the `REGION` environment variable as one of the following
numeric regions:

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

If your server was in Europe:

```shell
docker run --name l4d2-region \
    -e REGION=3 \
left4devops/l4d2
```

#### STEAM_GROUP

Make your server easier to join, by attaching it to a Steam Group. Steam Group Servers are shown in the bottom right
corner of the Game menu and can be easily picked as a hosting option in Left 4 Dead 2. In game, players can press `h` to
show the message of the day and then join your steam group, so they can find it again in the future. You can find the ID 
of your Steam Group at the top of the Admin page.

```shell
docker run --name l4d2-group \
    -e STEAM_GROUP=666 \
left4devops/l4d2
```

##### STEAM_GROUP_EXCLUSIVE

Normally, your server will be available for anyone using the **Best Available Dedicated** setting in their lobby. You
can prevent this by setting `STEAM_GROUP_EXCLUSIVE` to true. Any member of your group will be able to start a game as
lobby leader.

```shell
docker run --name l4d2-group-exclusive \
    -e STEAM_GROUP=666 \
    -e STEAM_GROUP_EXCLUSIVE=true \
left4devops/l4d2
```

> [!NOTE]
> Non members can still pick your server using `mm_dedicated_force_servers`

#### PORT

The game should find the next free port after 27015 to host the game on.  If using bridge networking, 27015 will usually
be picked automatically, as no other services should be running in the container. You may prefer to hardcode the game
port to simply your port forwarding or firewall configuration. Simply set `PORT` to your desired port.  Game traffic and
RCON always operate on the same port number.

Change the port with host networking:

```shell
docker run --name l4d2-port \
    -e PORT=27016 \
    --network host \
left4devops/l4d2
```

or if using bridge networking, remember to expose your new ports:

```shell
docker run --name l4d2-port-bridged \
    -e PORT=27016 \
    -p 27016:27016/tcp \
    -p 27016:27016/udp \
left4devops/l4d2
```

To make it slightly less painful to change the port, you could use:

```shell
PORT=27017
docker run --name l4d2-port-var \
    -e PORT=$PORT \
    -p $PORT:$PORT/tcp \
    -p $PORT:$PORT/udp \
left4devops/l4d2
```
> [!WARNING]
> When publishing your ports with bridge networking, ensure the same port is used for both client and host. Otherwise
> matchmaking will advertise the wrong port and new players will not be able to connect

#### DEFAULT_MAP

Can be used to set the map when the server is first loaded. Defaults to the newest map for each game. The map names are
different in each game. You can get a full list of maps names by typing `maps` in your Developer Console. To start your
L4D2 server on Dead Center:

```shell
docker run --name l4d2-map \
    -e DEFAULT_MAP=c1m1_hotel \
left4devops/l4d2
```

#### DEFAULT_MODE

Sets the mode used by your server when it is first loaded. Defaults to coop, but can be changed from a lobby.

```shell
docker run --name l4d2-mode \
    -e DEFAULT_MODE=versus \
left4devops/l4d2
```

#### GAME_TYPES

Can be used to limit which game modes can be played on your server. Leave unspecified to allow all game modes. Values
include `coop,realism,survival,versus,scavenge,dash,holdout,shootzones`

```shell
docker run --name l4d2-modes \
    -e GAME_TYPES="versus,mutation19" \
left4devops/l4d2
```

#### FORK

Run multiple games from the same container, with ports being automatically allocated by default. The `PORT` variable is 
ignored. You can customise the behaviour of the different instances by mounting multiple **server##.cfg** files.

```shell
docker run --name l4d2-forked \
    --network host \
    -e FORK=2
    -v $pwd/server01.cfg:/cfg/server01.cfg
    -v $pwd/server02.cfg:/cfg/server02.cfg
left4devops/l4d2
```

#### LAN

Runs the server without needing to talk to Steam, but connecting players need a local IP address.

```shell
docker run --name l4d2-lan \
    --network host \
    -e LAN=true \
left4devops/l4d2
```

#### RCON_PASSWORD

> Son, we're immune, we're tired, and there's infected in the damn woods. Now cut the shit and let us in!

To issue commands to the server whilst you're playing on it, set an RCON password. Logging into a server with RCON also
grants you vote kick immunity. To set a password:

```shell
docker run --name l4d2-rcon \
    --network host \
    -e RCON_PASSWORD=cuttheshitandletusin \
left4devops/l4d2
```

Then in game, once you have joined the server, open the Developer Console and type

```
rcon_password cuttheshitandletusin
rcon
```

> [!NOTE]
> Make sure the password is unique, as bad actors commonly attempt dictionary attacks. `srcds_run` will
> ban an IP after a few failed attempts. This can have the unintended side effect of banning everyone if using bridge
> networking.

#### NET_CON_PORT

Similar to RCON, the Network Console allows you to administrator your server, but using a `telnet` client. If not using
a password, I would strongly recommend using a firewall to block public access to the port. To start listening on port
17017:

```shell
docker run --name l4d2-netcon \
    --network host \
    -e NET_CON_PORT=17017 \
left4devops/l4d2
```

You could then connect using your telnet client:

```shell
telnet localhost 17015
```

##### NET_CON_PASSWORD
To set a net con password:

```shell
docker run --name l4d2-netcon-password \
    --network host \
    -e NET_CON_PORT=17015 \
    -e NET_CON_PASSWORD=cuttheshitandletusin \
left4devops/l4d2
```

Once connected via your telnet client, type **PASS** and then your password:

```shell
telnet localhost 17015
PASS cuttheshitandletusin
```

A telnet client is included in the image so you can connect using `docker exec`:

```shell
docker exec -it l4d2 telnet localhost 17015
```

#### EXTRA_ARGS

Got a small number of other settings you want to add? To spawn larger mobs more frequently:

```shell
docker run --name l4d2-args \
    -e EXTRA_ARGS="+z_mega_mob_size 100 +z_mega_mob_spawn_min_interval 180 +z_mega_mob_spawn_max_interval 600" \
left4devops/l4d2
```

### server.cfg

`srcds_run` will look for a `server.cfg` file. If you have lots of config, store them in a file and mount it to
`/cfg/server.cfg`.

```shell
docker run --name l4d2-server-cfg \
    -v $(pwd)/server.cfg:/cfg/server.cfg
left4devops/l4d2
```

### Command line replacement

You can completely replace the guided environment variable configuration by providing arguments when starting the
container

```shell
docker run --name l4d2-command-line \
left4devops/l4d2 +hostname "Vannah Hotel"
```

