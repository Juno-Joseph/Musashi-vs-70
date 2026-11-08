extends State
class_name BlockState

@export var move_state : State
@export var parry_window: float = 0.2
@export var parry_animation : String = "Parry"
@export var block_animation : String = "Block"
@export var attack_state : State
@export var attack_node : String = "Attack"

@onready var parry_timer : Timer = $Timer

var is_parrying : bool = false

var timer : Timer

func on_enter():
	playback.travel("Block")
	character.velocity = Vector2.ZERO
	can_move = false
	is_parrying = false
		
	if parry_timer:
		parry_timer.star(parry_window)
	pass

func on_exit():
	can_move = true
	is_parrying = false
	if parry_timer and not parry_timer.is_stopped():
		parry_timer.stop()
	pass

func state_inpur(event: InputEvent):
	if event.is_action_released("Block") and not is_parrying:
		emit_signal("interrupt_state", move_state)
	pass

func can_parry() -> bool:
	return parry_timer != null and not parry_timer.is_stopped()
	return false

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
	pass

func _on_timer_timeout():
	emit_signal("interrupt_state", move_state)
	pass
