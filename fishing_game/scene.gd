extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimationPlayer").play('PalmTreeAction')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
