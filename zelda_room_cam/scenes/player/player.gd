extends KinematicBody2D

onready var world = get_parent()

### movement vector components
var dir_x
var dir_y
export var move_speed = 16


func _process(delta):
	_move()

func _move():
	
	### movement input
	dir_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	dir_y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	### applying movement
	move_and_slide(Vector2(dir_x, dir_y).normalized() * move_speed)
	### flooring our position, so that we get which room we are in currently
	var f_x = floor(global_position.x / world.room_size.x)
	var f_y = floor(global_position.y / world.room_size.y)
	### updating our current room
	world.player_room = Vector2(f_x, f_y)
