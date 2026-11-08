extends Area2D

@export var damage : int = 10

func _ready():
	monitoring = false


func _on_body_entered(body):
	if body == get_parent():
		print("you hit yourself")
		return
	
	for child in body.get_children():
		if child is Damageable:
			var knockback_vector : Vector2 = (body.global_position - get_parent().global_position).normalized()
			
			#Check if the player parried enemy
			var was_parried = child.hit(damage, knockback_vector)
			
			if was_parried:
				print("Enemy Sword realized it was parried!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
				#Find enemy's damagabel node
				var my_damageable = get_parent().get_node_or_null("Damageable")
				if my_damageable:
					#Deal 0 damage to the enemy to stagger them 
					my_damageable.hit(0, -knockback_vector)
