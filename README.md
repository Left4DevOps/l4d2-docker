# Left 4 Dead 2 Server Docker Image

## Ports
By default, you'll want to allow both incoming TCP and UDP traffic on port 27015. 

`docker run -p 27015:27015/tcp -p 27015:27015/udp --name l4d2 morzlee/l4d2`

### Changing the port
To change the port used inside the container change the `PORT` environment variable, then map the new ports instead.

## Hostname
This identifies your server in the server browser.  By default it is set to "Left4DevOps L4D2".  Change it by setting the `HOSTNAME` environment variable.

e.g. To change your hostname to BILLS HERE:

`docker run -e HOSTNAME="BILLS HERE"`...

## Region
To help hint to Steam where your server is located, set the `REGION` environment variable as one of the following numeric regions:

| Location        | REGION   |
| --------------- | -------- |
| East Coast USA  | 0        |
| West Coast USA  | 1        |
| South America   | 2        |
| Europe          | 3        |
| Asia            | 4        |
| Australia       | 5        |
| Middle East     | 6        |
| Africa          | 7        |
| World (Default) | 255      |

e.g. If your server was in Europe:

`docker run -e REGION=3`...

## plugins type
There are two types plugins to choose.
One plugins package is anna, other is neko.
anna github address: https://github.com/Caibiii/AnneServer
neko github address: https://github.com/himenekocn/NekoSpecials-L4D2

Default plugins package is anna.

## Custom Addons
Softlink l4d2 maps to addons folder.
It would more convenience while you want add custom map. Exspecially when you have sourcemod plugins.
you just need mount your extra map folder to docker container /map . 
