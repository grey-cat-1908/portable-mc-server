# Your Portable Minecraft Server

This is a project that allows you to easily install and configure a minecraft server on your Raspberry Pi or other similar device.

## Advantages

- Easy and very fast installation
- Does not require any knowledge
- Portable (you can bring your Raspberry Pi wherever you want)
- It is cheap (No need to pay for anything other than electricity if you already have a Raspberry Pi)
- Runs on Raspberry Pi 4 and Raspberry Pi 5 (4G and 8GB model)
- You'll look cool in front of your friends if you run a server on the board (if they don't know what Raspberry Pi is)
- Does not load your computer
- You can control and configure everything (as long as your board has enough power)

## Setup

... ToDo...?

## Connecting to the server

... ToDo...?

## Configuring

You can configure nearly everything by setting up the following Enviroment Variables:

|  Variable  | Description | Value |
|---|---|---|
| `RAM`  | How much RAM do you want to allocate to the server?  | `1G` (default) |
| `MC_VERSION`  |  What version of Minecraft do you want to install? | `1.20.4` (default) |
| `MC_SERVER` | Which server should be installed automatically? (only `pufferfish`, `purpur`, `patina` are supported) | `purpur` (default) |
| `SSH_PASSWORD`  |  SSH password  | `admin` (default) |
| `FORCE_REINSTALL` | Would you like to reinstall your server? `1` - yes; `0` - no | `0` (default) |

**NOTE:** You can set Environment Variable within balenaCloud. On the left, simply click on “Device Variables” and then click the “Add Variable” button. Give it a name, and set the value.

**NOTE:** You can also delete everything on the server and automatically reinstall it. On the left, simply click on “Actions” and then click the “Purge Data” button. Insert `1` and click “Purge Data”.

![set variable demonstration](https://cdn.arbuz.icu/img/balena/balenaSetVariables.png)

## Using RCON

... ToDo...?

## Connecting to the server using SFTP

I recommend using FileZilla to connect to the server via SFTP.

### FileZilla User Guide

... ToDo...?

Once the connection is established, remember to navigate to the `/usr/src/mcfiles` directory.

## Changing server

Purpur is automatically installed the first time you run it. If you want to change it, you can set the environment variable `MC_SERVER`. (See the configuration section for more details.) Remember to reinstall the server afterwards (set `FORCE_REINSTALL` environment variable to `1`).

**NOTE:** Please note that `pufferfish` versions can only take integer values, i.e.: `1.19`, `1.20` can be specified; `1.20.4` cannot be specified, the game will not start. If you specify version `1.20`, you will be able to play with `1.20.4`.

| Server | `MC_SERVER` value |
| --- | --- |
| [Pufferfish](https://github.com/pufferfish-gg/Pufferfish) | `pufferfish`  
| [Patina](https://github.com/PatinaMC/Patina) | `patina`  
| [Purpur](https://purpurmc.org/) | `purpur`  

## Installing plugins

... ToDo...?

## Mods...?

... ToDo...?
