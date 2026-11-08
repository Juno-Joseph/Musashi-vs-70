extends Node

class_name  Damageable

signal on_hit(node : Node, damage_taken : int, knockback_direction : Vector2)
signal on_parry()

@export var health : float = 20 :
	get:
		return health
	set(value):
		SignalBus.emit_signal("on_health_changed", get_parent(), value - health)
		health = value
@export var dead_animation_name : String = "Dead"


var is_parrying : bool = false
var is_blocking : bool = false

#return bool so that the enemy's sword knows if its attack succeeded
func hit(damage : int, knockback_direction : Vector2) -> bool:
	if is_parrying:
		emit_signal("on_parry")
		print("Parried")
		return true #Parried the attack 
	
	if is_blocking:
		#Player blocks attack. Return false so for no stagger but bypass subtracting health
		return false
	
	health -= damage
	emit_signal("on_hit", get_parent(), damage, knockback_direction)
	return false

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == dead_animation_name):
		get_parent().queue_free()
		
