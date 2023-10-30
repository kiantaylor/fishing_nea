extends Node

var money=2500
var lvl=1
var xp=30
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('money_boost'):
		money+=1000000
	if Input.is_action_just_pressed('level_boost'):
		lvl+=1
		xp=0
