# Sprint 1

Name: Bee Bussell
Github ID: BSBussell
Team Name: FireBox

### What you planned to do

* [Initialize the Godot Repo](https://github.com/utk-cs340-fall22/FireBox/issues/1)
* [Create a GameState and enable accessing it from the Main Menu](https://github.com/utk-cs340-fall22/FireBox/issues/3)
* [Handle Collision between two boxes](https://github.com/utk-cs340-fall22/FireBox/issues/7)

### What you did not do

* I finished all the issues assigned to me however, I did hope to have the project structured and organized

### What problems you encountered
* There was a situation where I finished up my issue and forgot to commit it. And the rest of my team was waiting on me to finish the commit before they could move forward.
* Just general game engine growing pains.
* Had an issue with one branch not being synced with main before I started working on it.


### Issues you worked on
Main Isssues
* [Initialize the Godot Repo](https://github.com/utk-cs340-fall22/FireBox/issues/1)
* [Create a GameState and enable accessing it from the Main Menu](https://github.com/utk-cs340-fall22/FireBox/issues/3)
* [Handle Collision between two boxes](https://github.com/utk-cs340-fall22/FireBox/issues/7)
Assisted:
* [Main Menu State](https://github.com/utk-cs340-fall22/FireBox/issues/2) *Wrote code allowing it to load game state and then cleaned up the ui*
* [Process Input](https://github.com/utk-cs340-fall22/FireBox/issues/6) *This is more of a technicality but I rewrote our input handlers to work for player 1 and player 2*
* [Be able to reset game state](https://github.com/utk-cs340-fall22/FireBox/issues/15) *I added a pause button that reloads the scene technically resetting the game state*


### Files you worked on
* backlog.md
* README.md
* project.godot
* GameState.tscn
* Game/GameState_old.tscn
* Game/GameState.tscn
* Game/GameState_KinematicBodyRework.tscn
* Game/Pause.gd
* Game/pause.png
* Game/Scripts/Changevis.gd
* Game/Scripts/Changevisf.gd
* Game/Scripts/kickBox.gd
* Game/Scripts/Pause.gd
* Game/Scripts/Test\ player.gd
* MainMenu/IMG/Firebox.png
* MainMenu/Main\ Menu.tscn
* MainMenu/Scripts/MainMenu.gd
* MainMenu/Scripts/QuitButton.gd
* MainMenu/Scripts/StartButton.gd
* MainMenu/UI/Button.tres


### What you accomplished

Essentially I setup a godot project, added a gamestate that could be accessed from a main menu that had an enviorment and then after my teammates parsed input and create objects that could move, I added collision boxes to them and reworked some of what they did to support Godot collision detection.

