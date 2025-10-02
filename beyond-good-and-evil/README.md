
## Description

This has my antimicro setup for mapping xbox 360 controller => keyboard for Beyond Good and Evil.

Compare to [default controls](https://strategywiki.org/wiki/Beyond_Good_%26_Evil/Controls)

## Details

I have created 2 profiles. The main difference is that I have switched the role of triggers as compared with console controller mappings; this was mostly due to preferring right trigger for attack. As a result, I ended up moving several other buttons to better accomodate things under that layout.

I have named them accordingly: Beyond-good-and-evil_trigger_is_attack and Beyond-good-and-evil_trigger_is_run. The latter is more similar to the original console mappings while the former is more customized and IMHO closer to most shooter games.

## Steam version

Note that the Steam version of the game defaults to having controller support (according to many posts online this wasn't always the case). Unfortunately, Ubisoft just hard-coded some controller mappings and gave no ability to edit layout or disable controller detection in the game.

Luckily, there is a way to tell wine/proton not to share the controller with the game which effectively lets us still map from controller -> antimicro -> keyboard and the game will still pick up the mapped keyboard bindings without issue.

See the page [here](https://raw.githubusercontent.com/zpangwin/antimicro-profiles/master/beyond-good-and-evil/01-prevent-games-directly-reading-controller) which covers the process. The Steam ID for Beyond Good and Evil (the 2003 version) is 15130. There is also a [remastered](https://store.steampowered.com/app/2556990/Beyond_Good__Evil__20th_Anniversary_Edition/) that comes whose ID is 2556990. Be sure not to get them mixed up.


----------------------------------

### "trigger_is_attack" Profile

This is my preferred profile but it is more customized and further away from original console mappings.

Number of Sets: 1

#### Set \#1

| Xbox 360 Controller    | Maps to                 | Description |
| :--------------------- | :---------------------- | :------------------------------ |
| Left joystick          | WASD keys               | Movement |
| Right joystick         | Mouse directions        | Camera |
| D-Pad Up, Down         | Up, Down arrow keys     | Switch Companions |
| D-Pad Left             | 2 key                   | Prev Item |
| D-Pad Right            | 3 key                   | Next Item |
| Right trigger          | Left Mouse button       | Attack/Interact/Take Picture/Shoot |
| Left trigger           | Right Mouse button      | Roll/Evade/Shoot disc, jump/attach/detach vehicles |
| A button               | Space key               | Run/Vehicle Acceleration/View menu item info |
| B button               | Left Control key        | Crouch/Vehicle Brakes |
| X button               | Q key                   | Use Item |
| Y button               | E key                   | Companion Button/Vehicle Compass |
| Guide button           | Left Shift key          | Enter Photo Mode |
| Back button            | Tab key                 | View map/Read emails |
| Start button           | Esc key                 | Pause/Subscreen menu/Inventory |
| Left Bumper            | Mouse Wheel Down        | Zoom out during Photo Mode |
| Right Bumper           | Mouse Wheel Up          | Zoom in during Photo Mode |
| Right Stick (press)    | C key                   | Recenter Camera |

----------------------------------

### "trigger_is_run" Profile

This is closer to original (xbox 360) console mappings but I am less likely to keep it updated; consider this to be my "red-headed step-child" profile as it were.

Number of Sets: 1

#### Set \#1

| Xbox 360 Controller    | Maps to                 | Description |
| :--------------------- | :---------------------- | :------------------------------ |
| Left joystick          | WASD keys               | Movement |
| Right joystick         | Mouse directions        | Camera |
| D-Pad Up, Down         | Up, Down arrow keys     | Switch Companions |
| D-Pad Left, Right      | Left, Right arrow keys  | Switch Items |
| Right trigger          | Space key               | Run/Vehicle Acceleration/View menu item info |
| Left trigger           | Left Control key        | Crouch/Vehicle Brakes |
| A button               | Right Mouse button      | Roll/Evade/Shoot disc, jump/attach/detach vehicles |
| B button               | Q key                   | Use Item |
| X button               | Left Mouse button       | Attack/Interact/Take Picture/Shoot |
| Y button               | E key                   | Companion Button/Vehicle Compass |
| Guide button           | Left Shift key          | Enter Photo Mode |
| Back button            | Tab key                 | View map/Read emails |
| Start button           | Esc key                 | Pause/Subscreen menu/Inventory |
| Left Bumper            | Mouse Wheel Up          | Zoom in during Photo Mode |
| Right Bumper           | Mouse Wheel Down        | Zoom out during Photo Mode |
| Right Stick (press)    | C key                   | Recenter Camera |

----------------------------------
