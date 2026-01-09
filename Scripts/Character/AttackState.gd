extends State

class_name AttackState

@export var return_state : State
@export var return_animation_node : String = "Run"
@export var attack_name : String = "attack"


@onready var timer = $Timer

func state_input(event : InputEvent):
	if(event.is_action_pressed("Attack")):
		timer.start()

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name.begins_with("Slash_")):
		if (timer.is_stopped()):
			next_state = return_state
			playback.travel(return_animation_node)
		else:
			pass
