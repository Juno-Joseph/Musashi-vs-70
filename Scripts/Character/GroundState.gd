extends State

class_name GroundState

@export var attack_state : State
@export var attack_node : String = "Attack"
@export var block_state : State
@export var block_node : String = "Block"


func state_input(event: InputEvent):
	if (event.is_action_pressed("Attack")):
		attack()
	elif (event.is_action_pressed("Block")):
		block()

func attack():
	next_state = attack_state
	playback.travel(attack_node)

func block():
	next_state = block_state
	playback.travel(block_node)
