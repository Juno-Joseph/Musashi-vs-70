extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine


var player_chase = false
var player = null

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	move_and_slide()

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true
	if state_machine.chase_state != null:
		state_machine.on_state_interrupt_state(state_machine.chase_state)

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false
