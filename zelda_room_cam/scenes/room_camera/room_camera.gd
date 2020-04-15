extends Camera2D

onready var world = get_parent()
onready var player = get_tree().get_nodes_in_group("player")[0]

export var response = 10

func _process(delta):
	_move_camera(delta)
	
func _move_camera(delta):
	### getting the rounded (important, as our camera is centered, not top-left originated) position to get the room the camera is currently in
	### pay attention to the camera position in the hierarchy - it is not a child of the player!
	var round_pos = Vector2(round(global_position.x), round(global_position.y))
	
	### the camera position should be equal the position of the room' centre the player is in
	var desired_pos = world.player_room * world.room_size + world.room_size * 0.5
	
	### if the desired and current positions match, we just return as we have nothing to do
	if round_pos == desired_pos:
		return
	### but in case the two does not match, then we linear interpolate the camer's position to the next room's centre
	### could also just warp the position like:
	### global_position = world.player_room * world.room_size + world.room_size * 0.5
	else:
		global_position = lerp(global_position, world.player_room * world.room_size + world.room_size * 0.5, delta * response)
		
