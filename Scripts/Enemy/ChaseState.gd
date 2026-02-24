extends State

class_name ChaseState

@export var idle_state : State

func on_enter():
	playback.travel("Running")
	can_move = true

func on_exit():
	character.velocity = Vector2.ZERO
	can_move = false

func _physics_process(delta):
	if character.state_machine.current_state != self:
		return
	
	if character.player_chase and character.player:
		var direction = (character.player.global_position - character.global_position).normalized()
		
		character.velocity = direction * character.speed
		character.animation_tree.set("parameters/Idle/blend_position", direction)
		character.animation_tree.set("parameters/Running/blend_position", direction)
	else:
		next_state = idle_state
