extends Marker3D


# Called when the node enters the scene tree for the first time.
func _ready():
	if PlayerData.wind:
		var load_wind=load('res://assets/screens/wind_sprite.tscn')
		for i in range(300):
			for j in range(300):
				var ping=randi_range(1,300)
				if ping==1:
					var new_grass=load_wind.instantiate()
					new_grass.position=Vector3(j-150,randf_range(10.0,-10.0),i-150)
					
					var scale_mod=randf_range(0.5,3.0)
					new_grass.scale=Vector3(scale_mod,scale_mod,scale_mod)
					add_child(new_grass)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
