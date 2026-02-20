extends State

class_name BlockState

@export var move_state : State

func on_enter():
	playback.travel("Block")
	can_move = false

func on_exit():
	character.can_move = true

func _on_parry_area_hit(area):
	if area.is_in_group("EnemyHitbox"):
		await character.freeze_frame(0.05, 0, .1)
		playback.travel("Parry")
		await get_tree().create_timer(0.3, true, false, true).timeout
		# After parry finishes, we return to move_state or stay in block?
		 # Usually, you return to move_state to give the player control back.
		next_state = move_state
