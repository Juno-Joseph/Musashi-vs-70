extends CharacterStateMachine
@export var chase_state : State

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	print("Enemy State Machine initialized")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
