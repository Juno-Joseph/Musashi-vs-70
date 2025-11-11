extends Area2D

@export var damage : int = 10

func _ready():
	monitoring = false

func _on_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			var knockback_vector : Vector2 = (body.global_position - get_parent().global_position).normalized()
			child.hit(damage, knockback_vector)
			
			await get_tree().create_timer(0.18, false).timeout
			await frame_freeze(0.1, 0.15)

func frame_freeze(timescale: float, duration: float) -> void:
	Engine.time_scale = timescale
	await get_tree().create_timer(duration, true, false, true).timeout
	Engine.time_scale = 1.0
