extends State
class_name BlockState

@export var move_state : State
@export var damageable: Damageable
@export var parry_window: float = 0.2

@onready var timer : Timer = $Timer

func _ready():
	# Listen for when the Damageable successfully intercepts a hit
	if damageable:
		damageable.connect("on_parry", _on_successful_parry)

func on_enter():
	can_move = false
	character.velocity = Vector2.ZERO
	playback.travel("Block")
	
	# turn defensive flags on
	if damageable:
		damageable.is_blocking = true
		damageable.is_parrying = true
	
	#Start the strict parry window timer
	if timer:
		timer.wait_time = parry_window
		timer.start()

func on_exit():
	can_move = true
	# Turn defensive flags off
	if damageable:
		damageable.is_blocking = false
		damageable.is_parrying = false
	if timer and not timer.is_stopped():
		timer.stop()

func state_input(event: InputEvent):
	#Exit block if the button is released
	if event.is_action_released("Block"):
		next_state = move_state

func _on_timer_timeout():
	# Window closed. We are still holding block, but no longer parrying
	if damageable:
		damageable.is_parrying = false

func _on_successful_parry():
	print("BlockState recieved signla and played animation!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	if timer and not timer.is_stopped():
		timer.stop()
	
	# Turn off parrying immediatly so it doesn't trigger twice
	if damageable:
		damageable.is_parrying = false
	
	playback.travel("Parry")
	
	# HitStop
	Engine.time_scale = 0.1
	await get_tree().create_timer(0.02, true, false, true).timeout
	Engine.time_scale = 1.0

func _on_animation_tree_animation_finished(anim_name):
	if anim_name.begins_with("Parry"):
		# When the parry animation finishes, check if player is still holing block button
		if Input.is_action_pressed("Block"):
			playback.travel("Block")
			if damageable:
				damageable.is_blocking = true
			else:
				next_state = move_state




#@export var move_state : State
#@export var parry_window: float = 0.2
#@export var parry_animation : String = "Parry"
#@export var block_animation : String = "Block"
#@export var attack_state : State
#@export var attack_node : String = "Attack"
#
#@onready var parry_timer : Timer = $Timer
#
#var is_parrying : bool = false
#
#var timer : Timer
#
#func on_enter():
	#playback.travel("Block")
	#character.velocity = Vector2.ZERO
	#can_move = false
	#is_parrying = false
#
#
#func on_exit():
	#can_move = true
	#is_parrying = false
	#if parry_timer and not parry_timer.is_stopped():
		#parry_timer.stop()
	#
#
#func state_input(event: InputEvent):
	#if event.is_action_released("Block") and not is_parrying:
		#next_state = move_state
#
#
#func can_parry() -> bool:
	#return parry_timer != null and not parry_timer.is_stopped()
#
#
#func _on_parry_area_hit(area):
	#if area.is_in_group("EnemyHitbox"):
		#if timer and not timer.is_stopped():
			#timer.stop()
		#
		#await character.freeze_frame(0.05, 0, .1)
		#playback.travel("Parry")
		#await get_tree().create_timer(0.3, true, false, true).timeout
		## After parry finishes, we return to move_state or stay in block?
		 ## Usually, you return to move_state to give the player control back.
		#emit_signal("interrupt_state", move_state)
#
#
#func _on_timer_timeout():
	#emit_signal("interrupt_state", move_state)
