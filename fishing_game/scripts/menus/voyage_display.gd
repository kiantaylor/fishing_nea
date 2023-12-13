extends Control
var voyage
var title=['',"'s voyage to ",'']
var dots='.'
signal set_sail
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("title").text=str(title[0]+title[1]+title[2])
	var count=0
	for i in get_node("fish_list").get_children():
		if count< len(voyage.get_populations()):
			i.update_species(voyage.get_populations()[count].get_species())
			i.update_value(voyage.get_ratio()[count])
		else:
			i.update_species(dots)
			i.update_value(0)
			
		count+=1

func _on_timer_timeout():

	dots=dots.erase(dots.count('.'),len(dots)-dots.count('.'))
	if dots.count('.')<6:
		dots+='.'
		for i in 6-dots.count('.'):
			dots+=' '
	
	else:
		dots='.    '
	if voyage:
		
		if voyage.get_boat():
			title[0]=voyage.get_boat().get_boat_name()
		else:
			title[0]=dots
			
		if voyage.get_zone()!='':
			title[2]=voyage.get_zone().capitalize()
		else:
			title[2]=dots
			
	else:
		title[0]=dots
		title[2]=dots

	
	

		






func _on_recurring_toggled(button_pressed):
	voyage.recurring=button_pressed


func _on_confirm_pressed():
	if voyage.get_boat() and voyage.get_zone():
		voyage.activate()
		VoyageData.current_voyages.append(voyage)
		emit_signal('set_sail')
