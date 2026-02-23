extends Label

@export var state_machine : CharacterStateMachine

func _process(delta):
	if state_machine and state_machine.current_state:
		text = "State : " + state_machine.current_state.name
	else:
		text = "State : Initializing..."
