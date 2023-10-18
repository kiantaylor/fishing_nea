extends Node3D
var started=false
var open=false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimationPlayer").play('startup')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and started and not open:
		get_node("AnimationPlayer").play('open')

func _on_animation_player_animation_finished(anim_name):
	if anim_name=='startup':
		started=true
	elif anim_name=='open':
		open=true
