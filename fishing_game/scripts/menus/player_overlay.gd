extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("money").text='money: '+str(PlayerData.money)
	get_node("level/xp").text='xp: '+str(PlayerData.xp)+' / '+str(PlayerData.xp_threshold)
	get_node("level/title").text='level: '+str(PlayerData.lvl)
	get_node("level").value=PlayerData.xp
	get_node("level").max_value=PlayerData.xp_threshold
