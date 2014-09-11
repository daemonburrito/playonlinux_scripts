# Installer scripts for PlayOnLinux games

WIP bash installer scripts: See http://www.playonlinux.com/en/

## `cfg_parser.py`

A utility to find common and unique dosbox settings.

### Usage
The following will print the common settings between the conf files, and then the unique settings as `CONFIG.COM` commands.

```bash
$ ./cfg_parser.py path1.conf path2.conf path3.conf -o configcom
** Global config **
[sdl]
autolock=true
fullresolution=desktop
waitonerror=true
priority=higher,normal
fullscreen=true
sensitivity=100
fulldouble=false
usescancodes=true
windowresolution=original

** Config 1 **
CONFIG -set "sdl mapperfile=mapper.txt"
CONFIG -set "sdl output=Overlay"
CONFIG -set "sdl aspect=false"

** Config 2 **
CONFIG -set "sdl mapperfile=mapper.map"
CONFIG -set "sdl output=overlay"

** Config 3 **
CONFIG -set "sdl mapperfile=mapper.map"
CONFIG -set "sdl output=overlay"
```

See `./cfg_parser.py -h` for options.

### Limitations

It's not yet smart enough to deal with option values with are case-insenstive, so you'd have to eyeball something like:

```
CONFIG -set "sdl windowresolution=original"
[...]
CONFIG -set "sdl windowresolution=Original"
```

Extra logic is needed to determine if the option value would be harmed if lower-cased (e.g., if it's a path).

## License

GPLv2
