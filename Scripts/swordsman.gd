extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

@export var hit_state : State
@export var starting_move_direction : Vector2 = Vector2.LEFT
@export var speed : float = 170.0

func _ready():
	animation_tree.active = true
	

func _physics_process(delta):
	var direction : Vector2 = starting_move_direction
	if direction && state_machine.check_if_can_move():
		velocity.x = direction.x * speed
		velocity.y = direction.y * speed
	elif state_machine.current_state != hit_state:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()
	
