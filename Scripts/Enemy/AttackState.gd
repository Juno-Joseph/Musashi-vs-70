extends State

class_name EnemyAttackState

@export var return_state : State
@export var attack_node : String = "Attack"

func on_enter():
	
	playback.travel(attack_node)
	
	if character.player:
		var direction = (character.player.global_position - character.global_position).normalized()
		print_debug("Attack Direction: ", direction)
		character.animation_tree.set("parameters/Attack/blend_position", direction)
	
	playback.travel(attack_node)

func _on_animation_tree_animation_finished(anim_name):
	if anim_name.begins_with("Slash"):
		next_state = return_state
