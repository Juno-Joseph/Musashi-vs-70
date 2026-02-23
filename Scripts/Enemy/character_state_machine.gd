extends CharacterStateMachine

@export var chase_state : State
@export var attack_state : State
@export var idle_state : State



# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	print("Enemy State Machine initialized")
	
	if idle_state:
		current_state = idle_state
		current_state.on_enter()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
