extends State

class_name BlockState

@export var move_state : State

@onready var parry_area = character.get_node("../Parry")

func on_enter():
	playback.travel("Block")
	parry_area.area_entered.connect(_on_parry_area_hit)
	parry_area.monitoring = true
	can_move = false

func on_exit():
	parry_area.area_entered.disconnect(_on_parry_area_hit)
	parry_area.monitoring = false
	character.can_move = true

func _on_parry_area_hit(area):
	if area.is_in_group("EnemyHitbox"):
		await character.freeze_frame(0.05, 0,.1)
		playback.travel("Parry")
		await get_tree().create_timer(0.3, true, false, true).timeout
		next_state = move_state

func state_input(event : InputEvent):
	pass
