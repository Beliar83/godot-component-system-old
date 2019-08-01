========
Overview
========
GodotComponentSystem is a data driven system for the godot engine. It allows
writing programs that work by simply reading and manipulation data.

A component system consists of the following things: A game world, registered components, game objects and game systems.

==========
Game world
==========
The game world is the main class for a component system. It holds the component registry, the game system registry and all game objects.

==========
Components
==========
A component is a class that defines the fields that can be set on that component. They have to be registered to a game world to be usable.

============
Game objects
============
A game object is a storage for component data.

============
Game systems
============
A game system can be used to periodically process component data. It has the
normal _process, _physics_process methods and also an _before_physics_process
method.
The latter can, for example, be used to synchronize data between godot nodes and the game object.

============
Code example
============
This is an explanation of the demo script found 
:download:`here <../../../code/demo/DemoScene.gd>`.

I am going to assume that the basics of Godot and Godotscript are known, so we will focus on the parts specific to GodotComponentSystem.

The level for this consists of a simple Node2D as the root and a Sprite, named "DemoNode" with the Godot logo as a texture.

The scene script has 2 class variables, which will store the world and the game object for the "DemoNode".::

    var demo_object : GameObject
    var demo_world : GameWorld

In the ready function we first create a new game world and register
the :download:`position component <../../../code/demo/components/position.gd>`::

    demo_world = GameWorld.new()
    demo_world.components["position"] = PositionComponent

The "position" string is what will later be used to access the component
fields on the specific game objects.

After that we set the root node of the world to the scene::

        demo_world.root_node = self

The root node is necessary for the world to find nodes. Any node paths should
be relative to this node.

Next we create a :download:`movement system <../../../code/demo/systems/movement.gd>` and add it to the world::

    MovementSystem.new(demo_world)

The world automatically calls the process methods on registered systems.

In the next line the demo tries to load a previously stored world state::

    if demo_world.load("res://demo_object.tres"):
        demo_object = demo_world.DemoObject

If that failes a new object will be created::

    else:
        demo_world.DemoObject = GameObject.new()
        demo_object = demo_world.DemoObject

And the the node field of game object will be set to the path of
the "DemoNode"

        demo_object.node = get_path_to($"DemoNode")

The _process method just calls the _process method of the world.

The _physics_process method first adjusts data on the demo object and then
calls the _physics_process of the world::

    demo_object.position.vector.x += 10 * delta
    demo_object.position.vector.y += 10 * delta
    demo_world._physics_process(delta)

The world will call the methods on the systems. The movement system will
update the values of the "DemoNode".

The _input method demonstrates some additional functionality.
The first allows the user to click on the scene and set the position of the
"DemoNode" to the position of the click, which will be the base for the next
call of _physics_process::

    if event is InputEventMouseButton:
        if !event.pressed:
            demo_object.position.vector = event.position

Also pressing "S" will save the current state of the world which will be
loaded at the next start of the demo::

    if event is InputEventKey:
        var key_event = event as InputEventKey
        if key_event.scancode == KEY_S:
                demo_world.save("res://demo_object.tres")

The :download:`position component <../../../code/demo/components/position.gd>`
does not need much explanation. It is just a class that extends Component and
defines the fields for the component. Note that the export statement is needed
for saving to work.

Now we will take a look at the
:download:`movement system <../../../code/demo/systems/movement.gd>`,
specifically the _physics_process and _before_physics_process methods.

The _before_physics_process, as the name suggests, is called before
_physics_process.

In the _before_physics_process we handle copying of the data stored in the
components to the node.
First we get get a list all game objects that
have a specific component attached and iterate over it::

    func _before_physics_process(delta : float):
        for game_object in world.get_objects_with_component("position"):

Next for each object we first try to get the node from the node path set in
the game object and return if no node was found::

    var node = world.root_node.get_node(game_object.node)
        if node == null:
            return

After that the type of the Node is checked, the movement system supports
Node2D and Spatial. If the node is either of these types the respective values
for the type are being set. The movement system itself is 2D, so it only sets
the x and y values on a Spatial::

    if node is Node2D:
        node.position = game_object.position.vector
        node.rotation_degrees = game_object.position.rotation
    elif node is Spatial:
        node.translation.x = game_object.position.vector.x
        node.translation.y = game_object.position.vector.y
        node.rotation_degrees.y = game_object.position.rotation

The _physics_process method handles copying the node values, to the component.
This keeps the data in sync with the actual values::

    func _physics_process(delta):
        for game_object in world.get_objects_with_component("position"):
            var node = world.root_node.get_node(game_object.node)
            if node == null:
                return
            if node is Node2D:
                game_object.position.vector = node.position
                game_object.position.rotation = node.rotation_degrees
            elif node is Spatial:
                game_object.position.vector = Vector2(node.translation.x, node.translation.y)
                game_object.position.rotation = node.rotation_degrees.y

I hope this is enough to get you started and apologize that I am not a
better tutorial writer.
