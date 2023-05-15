# Sprint 3
- Name: Bee Bussell
- Githubid: BSBussell
- Group name: Firebox
- --
 ## What I did
- Added in hurtbox hitbox collision
- Rewrote th fireball code
- Reorganized the player code
## What I did not do
- Added in blocking
## Problems
- Blocking doesn't work properly right now because it's tied to the hurtbox because godot is funny
- kicking file structure could use some work
 ### Issues
 - [Be able to detect hitbox, hurtbox overlap](https://github.com/utk-cs340-fall22/FireBox/issues/14)
 - [Revamp Fireball](https://github.com/utk-cs340-fall22/FireBox/issues/47)
 - [Fix hitboxes and hurtboxes](https://github.com/utk-cs340-fall22/FireBox/issues/46)
 ### files I worked on
 - "FireBox\Godot Files\Game\Test player.gd"
 - "FireBox\Godot Files\Game\GameState_Kinematics.tscn"
 # Summary
A lot of what i did was just doing small things as I went starting with detecting hitbox, hurtbox overlap. From there I decided I needed to redo the fireball and make the hitboxes and hurtboxes more uniform across both players. This meant redoing how the players worked and making both of them an instance of the same scene,