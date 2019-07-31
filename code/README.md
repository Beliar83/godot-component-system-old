# godot-component-system
This is a data-driven component system for godot 3.1.

There are 4 main parts of this:

Components (component.gd) are simple data storages for the game logic.

GameObjects (gameObject.gd) are nodes that groups components.

GameSystems (gameSystem.gd) work with data of specific components.

The GameWorld (gameWorld.gd) is the main model for the data. It holds the component registry, the system registry and all game objects.
It also is the main access point from outside, as it is the only class that inherits from Node.