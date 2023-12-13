extends Marker2D
var gold=Color('ffe15f')
var silver=Color('a3c2cf')
var bronze=Color('e7b255')
var white=Color('ffffff45')

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func update_colours(stars):
	var new_colour
	if stars<=5:
		new_colour=bronze
	elif stars<=10:
		stars-=5
		new_colour=silver
	else:
		stars-=10
		new_colour=gold
	for i in get_children():
		if stars>0:
			i.modulate=new_colour
		else:
			i.modulate=white
		stars-=1
