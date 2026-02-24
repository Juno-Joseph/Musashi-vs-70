extends Area2D

@export var damage : int = 10

func _ready():
	monitoring = false


func _on_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			var knockback_vector : Vector2 = (body.global_position - get_parent().global_position).normalized()
			child.hit(damage, knockback_vector)
