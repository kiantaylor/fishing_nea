extends Marker2D

var size=6
var value=0
var species=''
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("title").text=species
	update_size(size)
	update_value(value)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func update_size(new_size):
	size=new_size
	get_node("bg").size.x=size*40
	if get_node('points').get_child_count()>size:
		for i in get_node("points").get_children():
			i.free()
	var count=get_node('points').get_child_count()
	while get_node('points').get_child_count()<size:
		var new_load=load("res://assets/screens/menus/ratio_point.tscn")
		var new_button=new_load.instantiate()
		new_button.position.y=2
		new_button.position.x=2+count*40
		get_node('points').add_child(new_button)
		count+=1
func update_value(new_value):
	value=new_value
	for i in get_node("points").get_children():
		i.on=false
	var count=0
	for i in get_node("points").get_children():
		if count<value:
			i.on=true
		count+=1
func update_species(new_species):
	species=new_species
	get_node("title").text=species
	
