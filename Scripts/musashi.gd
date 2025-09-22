extends CharacterBody2D

@export var speed : float = 200
@export var animation_tree : AnimationTree 
@onready var musashi = get_owner()


var input : Vector2 = Vector2.ZERO
var playback : AnimationNodeStateMachinePlayback

func _ready():
	animation_tree.active = true

func _process(delta):
	update_animation_parameters()
	

func _physics_process(delta: float) -> void:
	input = Input.get_vector("left", "right", "up", "down").normalized()

	if input:
		velocity = input * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func update_animation_parameters():
	animation_tree.set("parameters/conditions/Idle", velocity == Vector2.ZERO)
	animation_tree.set("parameters/conditions/Run", velocity != Vector2.ZERO)
	animation_tree.set("parameters/conditions/Attack", Input.is_action_just_pressed("Attack"))
	
	if input != Vector2.ZERO:
		animation_tree["parameters/Idle/blend_position"] = input
		animation_tree["parameters/Run/blend_position"] = input
		animation_tree["parameters/Attack/blend_position"] = input
	
