# Description

Sometimes you hate a game's built-in controller layout(s) but there is no in-game option or config file to tell the game to just ignore the controller.

If you have a AntiMicroX profile you want to use, then you would be getting AMX's mapping *AND* the game acting on whatever its default mapping is... which is a pain in the behind.

AntiMicroX has a [wiki page](https://github.com/AntiMicroX/antimicrox/wiki/Methods-for-Disabling-Joystick-Reading-in-Linux) noting a few common solutions for Linux. But it is missing a few and also doesn't cover non-Linux systems at all.

This covers several options for working around these kind of issues. I am mostly focused on Linux but if you know of any ways that I have not documented here, please feel free to create an issue for the project and I may add it later (fair warning: it may take awhile for me to notice and get time to update but I do generally check every so often).

Also, you don't need to do *ALL* of these methods... just one. If you try one and it doesn't work, try another.

# Table of Contents

- [Options by Platform](#options-by-platform)
- [Option 1: Disable Steam Input](#option-1-disable-steam-input)
- [Option 2: Disable SDL2 (Wine or Proton games)](#option-2-disable-sdl2-wine-or-proton-games)
 - [Option 2, method A: wine controller gui](#option-2-method-a-wine-controller-gui)
 - [Option 2, method B: regedit](#option-2-method-b-regedit)
 - [Option 2, method C: system.reg](#option-2-method-c-systemreg)
- [Appendix A: How to find WINEPREFIX (using Wine)](#appendix-a-how-to-find-wineprefix-using-wine)
- [Appendix B: How to find wine binary (using Wine)](#appendix-b-how-to-find-wine-binary-using-wine)
- [Appendix C: How to find WINEPREFIX (using Proton)](#appendix-c-how-to-find-wineprefix-using-proton)
- [Appendix D: How to find proton/wine binary (using Proton)](#appendix-d-how-to-find-proton-wine-binary-using-proton)


## Options by Platform

| Platform                       | Option(s) |
|:------------------------------:|:-------:|
| Linux (using Proton/Proton-GE) | |
| Linux (using wine/bottles)     | |
| Linux (using native games)     | ??? (maybe SteamInput?) |
| Windows                        | [HideHide](https://github.com/nefarius/HidHide) |
| Mac                            | ??? (maybe SteamInput?) |


## Option 1: Disable Steam Input

Sometimes you can get lucky and simply disable a game from reading the input via Steam's per-game settings.

1. Open Steam to your Library page, find the game in the list along the left margin then right-click the game's title and choose Properties.
2. In the Properties dialog, look along the left margin for the `Controller` tab and click on it.
3. Change the `Override` dropdown so that `Disble Steam Input` is selected.
4. Close and restart Steam

This is correct for the Beta version of the Linux Steam Client as of October 2025. I don't own any Windows or Mac computers so I can't test those.



## Option 2: Disable SDL2 (Wine or Proton games)

This is the method I tend to use the most. There are several variations how you can go about it. The main differences between Wine and Proton in this context, are going to be the paths to the `WINEPREFIX` dir (for proton this is the `<steam>/compatdata/<steamid>/pfx` dir) and the binary you use. If you are comfortable backing up folders and directly editing wine/proton 'system.reg' files, that is even faster/easier in my opinion but I will cover each of the ways I know of to disable SDL2.


### Option 2, method A: wine controller gui

This is basically the same thing covered in [AntiMicroX's wiki page](https://github.com/AntiMicroX/antimicrox/wiki/Methods-for-Disabling-Joystick-Reading-in-Linux#wine-games) expect that they only cover how to do it from PlayOnLinux (an older wine wrapper app that isn't as common these days). I will show how to do this using only wine (or proton) which should work for pretty much all native install setups (I'm not sure about flatpaks); this comes from [here](https://forum.winehq.org/viewtopic.php?t=18275).


First, you need both the `WINEPREFIX` and wine binary for the game in question. (wine users - see [Appendix A](#appendix-a-how-to-find-wineprefix-using-wine) and [B](#appendix-b-how-to-find-wine-binary-using-wine) / proton users - see [Appendix C)](#appendix-c-how-to-find-wineprefix-using-proton) and [D](#appendix-d-how-to-find-proton-wine-binary-using-proton)).

Next, you need to either create or download a `.reg` file containing the keys/values to be added (such as the one I provided here: [disable-controller-in-current-wineprefix.reg](https://raw.githubusercontent.com/zpangwin/antimicro-profiles/master/01-prevent-games-directly-reading-controller/disable-controller-in-current-wineprefix.reg) and save it somewhere under the `drive_c` folder of your WINEPREFIX.

Then, you need to call `regedit` using either `wine` or `proton`

Last, you'll use the menu in `regedit` and have it load the `.reg` file that you copied somewhere under `drive_c`; it will then merge the registry changes.

From there, you should be done but it's always a good idea to load the game up for a quick test to confirm.


The wine command for regedit should look something like:

```bash
    WINEPREFIX="/path/to/your/wine/prefix" wine64 control joy.cpl
```

note: if you are not running this from the terminal but instead using a `.desktop` file or app launcher, then you may need to replace `$HOME` with its expanded value (e.g. `/home/YOUR_USER_NAME_HERE`)


The proton command for regedit should look something like

```bash
    WINEPREFIX="$HOME/.steam/steam/steamapps/compatdata/<YOUR_GAME_ID>/pfx" \
    "/media/ssd/SteamLibrary/steamapps/common/Proton - Experimental/files/bin/wine64" \
    control joy.cpl
```

alternately, you can use [protontricks](https://github.com/Matoking/protontricks) but sometimes users have issues with it.


In either case, you should see a GUI dialog come up with the title "Game Controllers" similarly to [AntiMicroX's wiki page](https://github.com/AntiMicroX/antimicrox/wiki/Methods-for-Disabling-Joystick-Reading-in-Linux#wine-games), though it will probably look a little different under new versions of wine. From here, you can either disable individual controllers or simply uncheck the "Enable SDL" checkbox. Then click the "Apply" button and "OK". Here is a picture of mine on Fedora using the default wine from central repos (currently `wine-10.15 (Staging)`).

![wine-control-joy-0-initial.png](https://github.com/zpangwin/zpangwin-antimicro-profiles/blob/master/01-prevent-games-directly-reading-controller/images/wine-control-joy-0-initial.png?raw=true)

and here is what it would look like if you unchecked "Enable SDL" (which will disable all controllers for the given WINEPREFIX):

![wine-control-joy-1a-disabling-all-controllers.png](https://github.com/zpangwin/zpangwin-antimicro-profiles/blob/master/01-prevent-games-directly-reading-controller/images/wine-control-joy-1a-disabling-all-controllers.png?raw=true)


If you opt to disable a controller instead of turning of SDL completely, be aware that for XInput-capable controllers (like Xbox ones), it will basically move the controller between 3 states: Connected-via-DirectInput, Connected-via-XInput, and Disabled. So in this case, it would start off as a Connected XInput device, then you would select it and click Override. This would move it to be a Connected DirectInput device. You would then need to select it again and click Disable. It would then get moved under the Disabled devices list.

Here's how that would look once it's all done:

![wine-control-joy-1b-disabling-a-specific-controller.png](https://github.com/zpangwin/zpangwin-antimicro-profiles/blob/master/01-prevent-games-directly-reading-controller/images/wine-control-joy-1b-disabling-a-specific-controller.png?raw=true)



### Option 2, method B: regedit

First, you need both the `WINEPREFIX` and wine binary for the game in question. (wine users - see [Appendix A](#appendix-a-how-to-find-wineprefix-using-wine) and [B](#appendix-b-how-to-find-wine-binary-using-wine) / proton users - see [Appendix C)](#appendix-c-how-to-find-wineprefix-using-proton) and [D](#appendix-d-how-to-find-proton-wine-binary-using-proton)).

Next, you need to either create or download a `.reg` file containing the keys/values to be added (such as the one I provided here: [disable-controller-in-current-wineprefix.reg](https://raw.githubusercontent.com/zpangwin/antimicro-profiles/master/01-prevent-games-directly-reading-controller/disable-controller-in-current-wineprefix.reg) and save it somewhere under the `drive_c` folder of your WINEPREFIX.

Then, you need to call `regedit` using either `wine` or `proton`

Last, you'll use the menu in `regedit` and have it load the `.reg` file that you copied somewhere under `drive_c`; it will then merge the registry changes.

From there, you should be done but it's always a good idea to load the game up for a quick test to confirm.


The wine command for regedit should look something like:

```bash
    WINEPREFIX="/path/to/your/wine/prefix" wine64 regedit
```

note: if you are not running this from the terminal but instead using a `.desktop` file or app launcher, then you may need to replace `$HOME` with its expanded value (e.g. `/home/YOUR_USER_NAME_HERE`)


The proton command for regedit should look something like

```bash
    WINEPREFIX="$HOME/.steam/steam/steamapps/compatdata/<YOUR_GAME_ID>/pfx" \
    "/media/ssd/SteamLibrary/steamapps/common/Proton - Experimental/files/bin/wine64" \
    regedit
```

credit goes to /u/ZarathustraDK on reddit for sharing this technique [here](https://www.reddit.com/r/wine_gaming/comments/hf5u14/wine_control_panel_controller_configuration/). (note: hispost mentions deleting entries containing VID_3344 but you shouldn't need to do this to simply disable the controller from appearing)


alternately, you might be able to use [protontricks](https://github.com/Matoking/protontricks) but sometimes users have issues with it.



### Option 2, method C: system.reg

**Disclaimer: WineHQ probably does not recommend this method. Only use it if you know what you're doing and have first confirmed no game processes are running.**

Same idea as method A, only you can directly edit the `system.reg` file in the game's `WINEPREFIX` dir. 

1. Make a backup of the `system.reg` file: `cp system.reg system.reg.$(date +%F%H%M%T).bak`
2. Edit file and save

Basically, just open the file in your favorite text editor - which is probably vim ;-P

Then search for `ControlSet001` and add the appropriate keys there. You can copypaste the time values and numbers to the right of the keys - they don't really matter.

But make sure there are keys for the parent levels too (e.g. if you only have `[System\\ControlSet001]` but no subkeys, then you'll need to create both `[System\\ControlSet001\\Services]` and `[System\\ControlSet001\\Services\\winebus]` keys - but if `[System\\ControlSet001\\Services]` already exists, obviously don't copy that part).


```
    ; only copy this part if [System\\ControlSet001\\Services] does not exist
    [System\\ControlSet001\\Services\\winebus] 1758290159
    #time=1dc296d20fea9b8


    [System\\ControlSet001\\Services\\winebus] 1758290159
    #time=1dc296d20fea9b8
    "Enable SDL"=dword:00000000
```

Don't forget to save the file changes.



## Option 3: Hotplugging (older games on any system)

TODO

For now, see [AntiMicroX's wiki page](https://github.com/AntiMicroX/antimicrox/wiki/Methods-for-Disabling-Joystick-Reading-in-Linux#wine-games)



## Option 4: SDL 2 Environment Variable (Linux)

TODO

For now, see [AntiMicroX's wiki page](https://github.com/AntiMicroX/antimicrox/wiki/Methods-for-Disabling-Joystick-Reading-in-Linux#wine-games)



## Option 5: SDLHack (Linux)

TODO

For now, see [AntiMicroX's wiki page](https://github.com/AntiMicroX/antimicrox/wiki/Methods-for-Disabling-Joystick-Reading-in-Linux#wine-games)

Note: The jspenguin site appears to be gone so the link mentioned on AntiMicroX wiki doesn't work anymore. I haven't looked if there's a mirror somewhere but I'm also wondering what this does differently than simply disabling SDL via wine (e.g. is it worth hunting down)?




## Option 6: Disable Read Access (Linux)

TODO

For now, see [AntiMicroX's wiki page](https://github.com/AntiMicroX/antimicrox/wiki/Methods-for-Disabling-Joystick-Reading-in-Linux#wine-games)



## Option 7: Different User (Linux)

TODO

For now, see [AntiMicroX's wiki page](https://github.com/AntiMicroX/antimicrox/wiki/Methods-for-Disabling-Joystick-Reading-in-Linux#wine-games)




## Option 8: WIP / Experimental (Linux)

TODO

Needs research / testing but could something like `sudo setcap cap_sys_rawio=eip /path/to/application` possibly work?

I think firejail also had something related to hidraw. Might look into whether firejail/bubblewrap could block a game's access. However, based on my previous research, this would likely be more for wine games or native games. I remember looking into Steam's proton experimental process stack back in Aug 2025 or so and there being some kind of internal bwrap process in there - so calling firejail/bwrap on steam or having them passed as a launch option similar to how mangohud works is probably off the table. Might be possible to hack some of Steam's proton scripts to add support for passing custom args as launch options

(or even better maybe request the ability to pass option flags thru from launch options/config file to pressure vessel's internal bwrap call as an official feature - but not sure if there is anywhere to actually submit feature requests. I think some proton source code is on github and some less well known pressure vessel repos are on gitlab. might be possible to request there but probably need to study the code first so they dont laugh at my request and reject it outright).




## Option 9: HideHide (Windows-only)

Disclaimer: I have not tried this myself and can't really say if it does as advertised. Just throwing it out there as a possibility, it's up to you to do your own research / virus scans / testing / etc.

[HidHide](https://github.com/nefarius/HidHide) is an open-source project for hiding controllers from games, written in c++.

from its readme page:

> HidHide is a kernel-mode filter driver available for Windows 10 or higher (KMDF 1.13+). It comes with a configuration utility via which the driver is configured and controlled. The filter driver starts automatically and runs unattended with system privileges. A system reboot may be triggered after driver installation or removal. The configuration utility runs in the least privileged mode and doesn't require elevated rights.

[HidHide release page](https://github.com/nefarius/HidHide/releases)



## Appendix A: How to find WINEPREFIX (using Wine)

When using `wine`, you will often need to know the `WINEPREFIX` directory.

I think the default is generally something like `/home/YOUR_USER_NAME_HERE/.wine` but honestly, I never use the default so I'm not sure.

Typically, users create separate `WINEPREFIX` dirs for each game and manually specify the `WINEPREFIX` path everytime it is called - whether that is from terminal commands, `.desktop` files, launcher apps (Lutris/Heroic/etc, or something else.


## Appendix B: How to find wine binary (using Wine)

If you only have 1 version of wine installed, you can probably just skip this section and simply use `wine`. Or if you need the full path, get the output from `command -v wine`

But if you have multiple versions of wine installed (such as from installing different WineHQ repos or having manually installed them at custom paths), then you might need to make sure you're calling the intended version.

In my experience, it generally doesn't mess things up if you open a `WINEPREFIX` using one version of `wine` then later change and use a different version on the same prefix. But "generally ok" is not the same as "never an issue" - especially if you are using a developer version or some custom fork, it could be creating some registry entries that might conflict when you switch back to your initial version.

As far as 32-bit or 64-bit versions of the wine binary (e.g. `wine` vs `wine64`), I don't recall this ever being an issue for me but it has been several years since I really messed with it. IIRC, what happens when you call `WINEPREFIX=/some/path/to/a/64-bit-prefix wine` is that `wine` will internally call `wine64` and pass it the prefix. But you may want to verify that.

Generally, when I only have 1 version of wine installed, I will just put `wine` in my commands and let the system resolve the path using the `$PATH` variable. But if I have multiple versions installed at different paths, then I will take the time to specify absolute paths to the `wine` binary.


## Appendix C: How to find WINEPREFIX (using Proton)


1. Open your web-browser and go to the store page of the game you want to play. Look in your Address Bar at the URL. There should be some url like `https://store.steampowered.com/app/40300/Risen/` - manually copy out the number from the store page (e.g. `40300`). That is called the 'Steam App ID' or 'Steam ID' or 'Game ID'.
2. **Make sure the game is installed locally and you have launched it at least once.**
3. Navigate to the `steamapps` folder on the drive you installed the game on. The default for Linux is `~/.local/Steam/steamapps` but on another drive it might look like `/media/ssd/SteamLibrary/steamapps`.
4. Find and enter the `compatdata` folder
5. Find and enter the folder corresponding to the ID from the first step (e.g. `40300` for Risen). If you don't see the folder, check that the game is installed, has been run at least once (since the folder isn't created until then). If still not finding it, check that it is instlled on the drive you think it is.
6. Find and enter the `pfx` folder.
7. Copy the path to this folder. You should see `drive_c` and several `.reg` files directly under it. This is the `WINEPREFIX` / `PROTONPREFX` for this game. It should look something like `/media/ssd/SteamLibrary/steamapps/compatdata/40300/pfx` or `/home/YOUR_USER_NAME_HERE/.local/Steam/steamapps/compatdata/40300/pfx`


Alternatively, for the first step, if you have [protontricks](https://github.com/Matoking/protontricks) installed you can search for the ID on the terminal using `protontricks -s <search_string>` and it will show you all the games that contain the given string and their IDs. Even if you are worried about changes made by protontricks, using it to simply query game ids should be safe (I do this myself and have never run into issues related to looking up the ID - aside from typos).



## Appendix D: How to find proton/wine binary (using Proton)

To find the proton binary, you'll want to start by finding which folder proton is in. You the most part, steam packages each major proton branch as if it were another game: it gets its own appid, it gets installed in the same `../steamapps/common` dir as games do, etc. The exception for this is any custom tools like SteamTinkerLaunch or Proton-GE because these are not packaged by Steam.

Every proton release will include a `wine` binary. If you are running a wine command (usually anything with a `WINEPREFIX`), then you will probably want this binary. If you are running some other command that specifically shows a `proton` binary, you probably will want to use that instead. The idea is that you first need to find the folder corresponding to the proton release you want to use, then search for the appropriate binary under that folder.

Alternately, you can use [protontricks](https://github.com/Matoking/protontricks) for much of this; see their documentation for more info and adjust commands as necessary if you prefer to go that route. But sometimes users have issues with protontricks so use as your own risk.

**For unofficial Steam runtimes (e.g. Proton-GE/SteamTinkerLaunch/etc):**

Look in your `~/.local/share/Steam/compatibilitytools.d` folder and find the desired runtime's install folder - go into this folder (e.g. `~/.local/share/Steam/compatibilitytools.d/GE-Proton9-26`)

**For official Steam runtimes:**

Either manually find the folder in you game install folder (e.g. `/media/ssd/SteamLibrary/steamapps/common/Proton - Experimental`) or alternately, open Steam to the Library page \> filter to `Proton` \> right-click the desired version \> choose Properties \> choose `Installed Files` tab \> click `Browse` button

**Then for both official or unofficial:**

The binary you want to use will vary depending on the command you are running. You can search from terminal using `find . -iregex '^.*/\(bin/wine*\|proton\)$'`

You'll want to construct the full path to the binary - or you can just cd to the directory and use the `realpath` command: e.g. `cd files/bin` then `realpath wine` should give something
like `/home/YOUR_USER_NAME_HERE/.local/share/Steam/compatibilitytools.d/GE-Proton9-26/files/bin/wine` or `/media/ssd/SteamLibrary/steamapps/common/Proton - Experimental/files/bin/wine`
