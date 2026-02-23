extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@export var speed : float = 150.0

var player_chase = false
var player = null

func _ready():
	animation_tree.active = true
	print("Enemy State Machine node: ", state_machine)
	print("Enemy Current State: ", state_machine.current_state)

func _physics_process(delta):
	if player_chase and player:
		var direction = (player.global_position - global_position).normalized()
		
		animation_tree.set("parameters/Idle/blend_position", direction)
		animation_tree.set("parameters/Running/blend_position", direction)
		
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true
	if state_machine.chase_state != null:
		state_machine.on_state_interrupt_state(state_machine.chase_state)

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false


func _on_attack_area_body_entered(body):
	if body.name == "Musashi":
		if state_machine.attack_state != null:
			state_machine.on_state_interrupt_state(state_machine.attack_state)
