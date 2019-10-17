extends Node

#Make sure this script is in the "AutoLoad" portion of the project settings with Singleton set to "Enable"
#When wanting to switch scenes, just use:
#Global.goto_scene(res://SCENENAME.tscn)

### Example:
#func score():
#	Global.score += 1
#	Global.goto_scene("res://ScoreScreen.tscn")
###

#required
var current_scene = null

#variables shared between scenes
var score = 0

func _ready():
    var root = get_tree().get_root() #let's define stuff as children of the root
    current_scene = root.get_child(root.get_child_count() - 1) #the -1 is to zero-index the returned child count

func goto_scene(path):
    call_deferred("_deferred_goto_scene", path) #call deferred or else our code will be interrupted when we switch scenes, causing crashes

func _deferred_goto_scene(path): #It is now safe to remove the current scene
    current_scene.free() #Delete old scene
    var s = ResourceLoader.load(path) #Load the new scene
    current_scene = s.instance() #Instance the new scene
    get_tree().get_root().add_child(current_scene) #Add it to the active scene, as a child of root
    
#If we need to procedurally load stuff because it's getting too big:
#https://docs.godotengine.org/en/3.1/tutorials/io/background_loading.html#doc-background-loading