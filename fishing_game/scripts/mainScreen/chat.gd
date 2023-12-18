extends Marker2D
var playing=false
var chats=[]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	visible=playing
func add_chat(text):
	print(text)
	var load_chat=load('res://assets/screens/menus/chat_pop_ups.tscn')
	var new_chat=load_chat.instantiate()
	new_chat.text=text
	
	add_child(new_chat)
	chats.append(new_chat)
	new_chat.position.y=26*chats.find(new_chat)
	new_chat.target_y=float(26*chats.find(new_chat))
func chat_death(chat):
	var place= chats.find(chat)
	chats.remove_at(place)
	if get_child_count()>0:
		for i in get_children():
			i.target_y=float(26*chats.find(i))
func voyage_end(boat,zone):
	var text= boat+"'s voyage to "+zone+' has ended'
	add_chat(text)
func voyage_start(boat,zone):
	var text= boat+"'s voyage to "+zone+' has started'
	add_chat(text)
func fish_added(fish,amount):
	var text= str(amount)+' '+fish.capitalize()+" added "
	add_chat(text)
func building_upgraded(building,level):
	var text= building+' upgraded to level '+str(level)
	add_chat(text)
func building_built(building):
	var text=building+' has been built'
	add_chat(text)
func boat_renamed(old_name,new_name):
	var text=old_name+' has been renamed '+new_name
	add_chat(text)
func boat_upgraded(boat,level):
	var text= boat+' upgraded to level '+str(level)
	add_chat(text)
func boat_bought(boat):
	var text=boat+' has been bought'
	add_chat(text)
func crew_hired(crew):
	var text=crew+' has been hired'
	add_chat(text)
func main_placement():
	position.x=2290
func menu_placement():
	position.x=1640
func menu_placement2():
	position.x=1750
