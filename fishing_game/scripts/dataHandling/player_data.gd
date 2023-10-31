extends Node

var money=2500
var lvl=1
var xp_threshold=0.0
var xp=30
# Called when the node enters the scene tree for the first time.
func _ready():
	xp_threshold=(2**((lvl-20)/3)+1)*100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('money_boost'):
		money+=1000000
	if Input.is_action_just_pressed('level_boost'):
		level_up()
	if xp>=xp_threshold:
		level_up()
func level_up():
	lvl+=1
	xp=0
	xp_threshold=int((2.0**((lvl-20.0)/3.0)+1.0)*100.0)
	print(xp_threshold)
