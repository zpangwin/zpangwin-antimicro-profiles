
## Description

This has my antimicro setup for mapping xbox 360 controller => keyboard for Mass Effect 1.

## Details

This also includes my game config files. I confirmed some values against the Proton version of the game on Mint 19.3 but have not actually tested these in-game.

Most of the changes had been previously tested in antimicro on windows several years back but there is a small possibility that I messed something up when remapping. Will update if/when I go back and confirm things in-game.

On Linux, BIOInput.ini goes in `<steam-dir>/steamapps/compatdata/17460/pfx/drive_c/users/steamuser/My Documents/BioWare/Mass Effect/Config` where SteamDir corresponds to either your custom steam library folder or the default of `~/.local/share/Steam`. Mine should have the "Toggle Fast Game Speed (for travel/cutscenes)" tweak/quickload/quicksave/etc already applied to work with this antimicro profile. Or if you want to set it up from scratch, you can read the details [here](https://masseffect.fandom.com/wiki/PC_Tweaks) - (search in page for "SloMo"). You will also need to setup Quick Save/Quick Load in this file. For the Quick Load to work, you will need to use Quick Save at least once, then in the file I provided, replace "Jessica01_QuickSave" with whatever yours is called (I named my character "Jessica" and I think it was my 2nd character so I got "01" instead of "00"... just look for the QuickSave filename in your save folder - `<compatdata-subfolder>/My Documents/BioWare/Mass Effect/Save`. Rename it match yours but omit the file extension)

Note: I tended to play as the soldier class so some of the descriptions (Set \#2 D-Pad in particular) are probably not correct for the other classes. I imagine the mappings will still work but will likely be adjusted to whatever replaces them in the other class but I did not actually test this. But we're limited to whatever the game provides, so if it doesn't work for some reason, check if there's something you can tweak in BIOInput.ini to get a mapping... otherwise, you just have to live with it (but you can replace the binding with something more useful to you).

Compare with [default controls](https://strategywiki.org/wiki/Mass_Effect/Controls) or [default xbox layout (pdf)](http://nxeassets.xbox.com/shaxam/0201/64/01/64013434-c686-4e65-bd5e-90b6af01b5f0.PDF?v=1)


Number of Sets: 2

### Set \#1


| Xbox 360 Controller    | Maps to                 | Description |
| :--------------------- | :---------------------- | :------------------------------ |
| Left joystick          | WASD keys               | Movement |
| Right joystick         | Mouse directions        | Camera |
| D-Pad Up               | Up arrow key            | Move Squad |
| D-Pad Right            | Right arrow key         | Target Enemy |
| D-Pad Down             | Down arrow key          | Take Cover |
| D-Pad Left             | Left arrow key          | Rally to Me |
| Right trigger          | Left Mouse button       | Fire |
| Left trigger           | Right Mouse button      | Zoom (Sniper) |
| A button               | E key                   | Interact |
| B button               | Q key                   | Draw/Holster Weapon |
| X button               | Space key               | Press: Skip Dialog, Hold: Select Ability |
| Y button               | F key                   | First Aid/Repair |
| Guide button           | (Not mapped)            | N/A (No action) |
| Back button            | R key                   | Throw/Detonate Grenade |
| Start button           | Esc key                 | Menu / Cancel |
| Left Bumper            | (Control Set 2)         | Use Set 2 while held |
| Right Bumper           | Z key                   | Run/Walk Toggle |

-----

### Set \#2

Note: Joysticks (Movement and Camera) and Trigger controls remain the same in both control sets to give you a fighting change when you get the occasional"oh fuck" situations where you are attacked while messing with something on control set \#2 / antimicro bugs out and locks on control set \#2 (rare but have had it happen a few times).

| Xbox 360 Controller           | Maps to                 | Description |
| :---------------------------- | :---------------------- | :------------------------------ |
| Left Bumper + D-Pad Up        | F1 key                  | Select Pistol |
| Left Bumper + D-Pad Right     | F2 key                  | Select Shotgun |
| Left Bumper + D-Pad Down      | F3 key                  | Select Assault Rifle |
| Left Bumper + D-Pad Left      | F4 key                  | Select Sniper Rifle |
| Left Bumper + A button        | E key                   | Same as Set 1: Interact |
| Left Bumper + B button        | Q key                   | Same as Set 1: Draw/Holster Weapon |
| Left Bumper + X button        | Space key               | Same as Set 1: Press: Skip Dialog, Hold: Select Ability |
| Left Bumper + Y button        | F key                   | Same as Set 1: First Aid/Repair |
| Left Bumper + Guide button    | (Not mapped)            | N/A (No action) |
| Left Bumper + Back button     | F5 key                  | Custom Binding: Quick Save |
| Left Bumper + Start button    | F6 key                  | Custom Binding: Quick Load |
| Left Bumper + Right Bumper    | Middle Mouse button     | Custom Binding: Toggle Fast Game Speed |

-----

### Diagram

![Preview of Layout](https://github.com/zpangwin/zpangwin-antimicro-profiles/blob/master/mass-effect1/MassEffect-1-custom-mappings.png?raw=true)

