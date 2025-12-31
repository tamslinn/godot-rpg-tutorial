class_name StateWalk extends State

@export var move_speed : float = 100.0
@onready var idle_state : State = $"../Idle"

## What happens when the player enters this state
func enter() -> void:
	player.update_animation("walk")
	
## What happens when the player exits this state	
func exit() -> void:
	pass
	
## What happens during the _process update in this state	
func process(_delta: float) -> State:
	if player.direction == Vector2.ZERO:
		return idle_state
		
	player.velocity = player.direction * move_speed
	
	if player.set_direction():
		player.update_animation("walk")
	return null
	
## What happens during the _physics update in this state	
func physics(_delta: float) -> State:
	return null
	
## What happens with input events in this state
func handle_input(_event: InputEvent) -> State:
	return null
