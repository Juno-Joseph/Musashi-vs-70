extends State

class_name GroundState

@export var attack_state : State
@export var attack_node : String = "Attack"

func state_input(event: InputEvent):
	if (event.is_action_pressed("Attack")):
		attack()

func attack():
	next_state = attack_state
	playback.travel(attack_node)
