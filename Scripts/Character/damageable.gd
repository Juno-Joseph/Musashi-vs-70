extends Damageable

func hit(damage : int, knockback_direction : Vector2) -> bool:
	# Check for parry
	if is_parrying:
		print("Musahsi Parried!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
		emit_signal("on_parry")
		return true #Parried the attack 
	
	# Check for block
	if is_blocking:
		#Player blocks attack. Return false so for no stagger but bypass subtracting health
		return false
	
	return super.hit(damage, knockback_direction)
