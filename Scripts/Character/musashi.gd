extends CharacterBody2D

@onready var musashi = get_owner()
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

@export var speed : float = 200
@export var animation_tree : AnimationTree


var input : Vector2 = Vector2.ZERO
var playback : AnimationNodeStateMachinePlayback

func _ready():
	animation_tree.active = true
	
func _physics_process(delta):
	input = Input.get_vector("left", "right", "up", "down").normalized()

	if input && state_machine.check_if_can_move():
		velocity = input * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()
	update_animation_parameters()

func update_animation_parameters():
	animation_tree.set("parameters/conditions/Idle", velocity == Vector2.ZERO)
	animation_tree.set("parameters/conditions/Run", velocity != Vector2.ZERO)
	animation_tree.set("parameters/conditions/Attack", Input.is_action_just_pressed("Attack"))
	animation_tree.set("parameters/conditions/Block", Input.is_action_just_pressed("Block"))
	#add parry conditions after blocking
	
	if input != Vector2.ZERO:
		animation_tree["parameters/Idle/blend_position"] = input
		animation_tree["parameters/Run/blend_position"] = input
		animation_tree["parameters/Attack/blend_position"] = input
		animation_tree["parameters/Block/blend_position"] = input
	
