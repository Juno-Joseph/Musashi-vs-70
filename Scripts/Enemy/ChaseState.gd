extends State

class_name ChaseState

@export var speed : float = 150.0
@export var idle_state : State

func on_enter():
	playback.travel("Running")
	can_move = true

func _physics_process(delta):
	if character.state_machine.current_state != self:
		return
	
	if character.player_chase and character.player:
		var direction = (character.player.global_position - character.global_position).normalized()
		
		character.velocity = direction * speed
		playback.set("parameters/Idle/blend_position", direction)
		playback.set("parameters/Run/blend_position", direction)
	else:
		next_state = idle_state
