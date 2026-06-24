extends HitState

@export var character_state_machine : CharacterStateMachine

func _on_timer_timeout():
	emit_signal("interrupt_state", return_state)
