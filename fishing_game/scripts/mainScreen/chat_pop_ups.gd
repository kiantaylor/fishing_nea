extends Label

signal death(chat)
# Called when the node enters the scene tree for the first time.
func _ready():
	connect('death',get_parent().chat_death)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	get_node("AnimationPlayer").play('fade')


func _on_animation_player_animation_finished(anim_name):
	emit_signal('death',self)
	queue_free()
