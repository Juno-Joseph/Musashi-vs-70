extends State

class_name HitState

@export var damageable : Damageable
@export var dead_state: State
@export var dead_animation_node : String = "Dead"
@export var knockback_speed: float = 100.0
@export var return_state : State
@export var animation_tree : AnimationTree

@onready var timer = $Timer

func _ready():
	damageable.connect("on_hit", on_damagable_hit)

func on_enter():
	timer.start()

func on_exit():
	character.velocity = Vector2.ZERO
	
func on_damagable_hit(node : Node, damage_amount : int, knockback_direction : Vector2):
		if (damageable.health > 0):
			playback.travel("Hit")
			character.velocity = knockback_speed * knockback_direction
			emit_signal("interrupt_state", self)
		else: 
			emit_signal("interrupt_state", dead_state)
			playback.travel(dead_animation_node)


func _on_timer_timeout():
	next_state = return_state
