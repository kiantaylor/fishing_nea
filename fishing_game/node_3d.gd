extends Node3D
var pos=[
	Vector3(-18,1,-12),Vector3(18,1,12),Vector3(18,1,-12),Vector3(-18,1,12),Vector3(-18,1,0),Vector3(18,1,0),Vector3(0,1,-12),Vector3(0,1,12)
]

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn():
	for i in pos:
		var file=load("res://assets/testing stuff/enemy.tscn")
		var instance=file.instantiate()
		instance.position=i
		instance.scale*=0.2
		add_child(instance)
		
func _on_timer_timeout():
	spawn() 
