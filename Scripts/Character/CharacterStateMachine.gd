extends Node

class_name CharacterStateMachine

@export var character : CharacterBody2D
@export var animation_tree : AnimationTree
@export var current_state : State
@export var damageable_component : Damageable # Reference to the Damageable node (Musashi/Damageable)
@export var hit_state : State
@export var dead_state : State

var playback : AnimationNodeStateMachinePlayback

var states : Array[State]

func _ready():
	for child in get_children():
		if (child is State):
			states.append(child)
			#Set states up with what they need to function
			child.character = character
			child.playback = animation_tree["parameters/playback"]
			
			#Connect to interrupt signal
			child.connect("interrupt_state", on_state_interrupt_state)
		else: 
			push_warning("Child " + child.name + "is not a State for CharacterStateMachine" )
	if is_instance_valid(damageable_component):
		damageable_component.connect("on_hit", on_damage_taken_interrupt)


func _physics_process(delta):
	if(current_state.next_state != null):
		switch_states(current_state.next_state)

func check_if_can_move():
	return current_state.can_move

func on_damage_taken_interrupt(node : Node, damage_amount : int, knockback_direction: Vector2):
	if damageable_component.health > 0:
		if hit_state is HitState:
			hit_state.knockback_direction = knockback_direction
		switch_states(hit_state)
	else:
		switch_states(dead_state)
		playback.travel(damageable_component.dead_animation_name)

func switch_states(new_state: State):
	if(current_state != null):
		current_state.on_exit()
		current_state.next_state = null
	current_state = new_state
	current_state.on_enter()

func _input(event: InputEvent):
	current_state.state_input(event)
	
func on_state_interrupt_state(new_state : State):
	switch_states(new_state)
