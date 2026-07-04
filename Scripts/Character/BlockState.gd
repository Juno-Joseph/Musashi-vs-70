extends State
class_name BlockState

@export var move_state : State
@export var attack_state : State
@export var attack_node : String = "Attack"

var timer : Timer

func on_enter():
	playback.travel("Block")
	character.velocity = Vector2.ZERO
	can_move = false
	
	if timer == null:
		timer = find_child("Timer")
	
	if timer != null:
		timer.start()
	else:
		print("ERROR: Timer node not found on", name)

func on_exit():
	can_move = true

func _on_parry_area_hit(area):
	if area.is_in_group("EnemyHitbox"):
		if timer and not timer.is_stopped():
			timer.stop()
		
		await character.freeze_frame(0.05, 0, .1)
		playback.travel("Parry")
		await get_tree().create_timer(0.3, true, false, true).timeout
		# After parry finishes, we return to move_state or stay in block?
		 # Usually, you return to move_state to give the player control back.
		emit_signal("interrupt_state", move_state)

func _on_timer_timeout():
	emit_signal("interrupt_state", move_state)
