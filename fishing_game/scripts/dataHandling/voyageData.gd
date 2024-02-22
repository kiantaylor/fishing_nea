extends Node

var current_voyages=[]
var new_voyage

signal voy_end_chat(boat,zone)
signal voy_start_chat(boat,zone)
# Called when the node enters the scene tree for the first time.
func _ready():
	connect('voy_end_chat',Chat.voyage_end)
	connect('voy_start_chat',Chat.voyage_start)
	emit_signal('voy_start_chat','boaty','hell')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func tick():
	for i in current_voyages:
		i.tick()
func voyage_ended(boat,zone):
	#('voyage end',boat,zone)
	emit_signal('voy_end_chat',boat,zone)
func voyage_started(boat,zone):
	#('voyage_start',boat,zone)
	emit_signal('voy_start_chat',boat,zone)

