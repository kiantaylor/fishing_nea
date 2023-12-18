extends Label

signal death(chat)
var target_y=0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	
	connect('death',get_parent().chat_death)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y=lerp(position.y,target_y,delta*3.0)


func _on_timer_timeout():
	get_node("AnimationPlayer").play('fade')


func _on_animation_player_animation_finished(anim_name):
	emit_signal('death',self)
	queue_free()
