# Tool-assisted Testing for Godot Engine
A Tool-assisted Testing plugin for Godot.
With this plugin it should be easy to quickly test character controllers, scripting inputs like in a _TAS_.

The only node that comes with this plugin is the `InputLayer`, which should be thought as a layer between any script and the `Input` singleton.

### Tat files
A _.tat_ file is a sequence of input states. Each input state has a duration.
The _.tat_ files editor comes with the plugin. After you have configured the `nametable` (see Usage), you can create, edit and save tat files. Here's  an example:
![Tat editor image](https://image.ibb.co/gnJBc0/image.png)

The duration is in seconds. You can change input state frame by frame setting the duration to 0.

You can press the _Add_ button on the bottom to add a new element to the sequence.

### Usage
- Add an instance of this node anywhere you want and call his methods (`is_action_pressed`, `is_action_just_pressed`, etc.) instead of the `Input` ones.
- Manually modify the `nametable` dictionary and the `Code` enum hardcoded in `sequence.gd` to bind your custom actions (this will be automatic soon)
- Add the character NodePath to the `Targets` array in `InputLayer`'s inspector
- Add the path of the _.tat_ file you want to execute to the `Sequence File Paths` array in `InputLayer`'s inspector
- Set `Mode` to `Test`
