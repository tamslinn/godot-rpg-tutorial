class_name StateIdle extends State

@onready var walk_state : State = $"../Walk"
@onready var attack_state : State = $"../Attack"

## What happens when the player enters this state
func enter() -> void:
	player.update_animation("idle")
	
## What happens when the player exits this state	
func exit() -> void:
	pass
	
## What happens during the _process update in this state	
func process(_delta: float) -> State:
	player.velocity = Vector2.ZERO
	if player.direction != Vector2.ZERO:
		return walk_state
	return null
	
## What happens during the _physics update in this state	
func physics(_delta: float) -> State:
	return null
	
## What happens with inout events in this state
func handle_input(_event: InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack_state
	return null
