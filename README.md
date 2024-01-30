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
| `MC_VERSION`  |  What version of Minecraft do you want to install?  | `1.20` (default) |
| `SSH_PASSWORD`  |  SSH password  | `admin` (default) |

**NOTE:** You can set Environment Variable within balenaCloud. On the left, simply click on “Device Variables” and then click the “Add Variable” button. Give it a name, and set the value.

![set variable demonstration](https://cdn.arbuz.icu/img/balena/balenaSetVariables.png)

## Connecting to the server using SFTP

I recommend using FileZilla to connect to the server via SFTP.

### FileZilla User Guide

... ToDo...?

Once the connection is established, remember to navigate to the `/usr/src/mcfiles' directory.

## Installing plugins

... ToDo...?

## Mods...?

... ToDo...?