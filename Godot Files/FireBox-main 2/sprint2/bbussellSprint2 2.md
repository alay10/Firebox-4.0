# Sprint 2
- Name: Bee Bussell
- Githubid: BSBussell
- Group name: Firebox
- --
 ## What I did
- Added an end lag system
- Added in fireball that exists on a seperate collision layer
- Added in jumping
## What I did not do
- I started work on flipping but never finished it and Andrew ended up developing that independently of me.
## Problems
- The fireball's collision box exist before it is drawn in and will stop the opponents fireball
- Jumping still has some jank to it with the way I implemented gravity occasionally resulting in the player just being slammed to the ground
- The endlag system isn't fool proof and can somehow be mashed through(ie the player pressed enough buttons at the same time they somehow can kick and fireball at the same time)
 ### Issues
 - [Fix the Kick](https://github.com/utk-cs340-fall22/FireBox/issues/22)
 - [Fireball](https://github.com/utk-cs340-fall22/FireBox/issues/20)
 - [Jumping](https://github.com/utk-cs340-fall22/FireBox/issues/19)
 ### files I worked on
 - "FireBox\Godot Files\Game\Test player.gd"
 - "FireBox\Godot Files\Game\GameState_Kinematics.tscn"
 # Summary
Adding the ability to jump along with throwing a fireball and an endlag system were all tasks that at the least have been implemented. I'm not exactly happy with their implementation and how they are in game. Specifically the fireball as that one was the hardest. Generally the fireball is the one that needs the most work. The rest of the code generally can stand on its own just needs some debugging and generally tweaking.