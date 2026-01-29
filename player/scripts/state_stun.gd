class_name StateStun extends State

@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0
@export var invulnerable_duration : float = 1.0

var hurt_box : HurtBox
var direction : Vector2

var next_state : State = null

@onready var idle_state : State = $"../Idle"

func init() -> void:
	player.player_damaged.connect(_player_damaged)


## What happens when the player enters this state
func enter() -> void:
	
	player.animation_player.animation_finished.connect(_animation_finished)
	
	direction = player.global_position.direction_to(hurt_box.global_position)
	player.velocity = direction * -knockback_speed
	player.set_direction()
	player.update_animation("stun")
	
	player.make_invulnerable(invulnerable_duration)
	player.effect_animation_player.play("damaged")
	
## What happens when the player exits this state	
func exit() -> void:
	player.animation_player.animation_finished.disconnect(_animation_finished)
	next_state = null
	
## What happens during the _process update in this state	
func process(delta: float) -> State:
	player.velocity -= player.velocity * decelerate_speed * delta
	return next_state
	
## What happens during the _physics update in this state	
func physics(_delta: float) -> State:
	return null
	
## What happens with input events in this state
func handle_input(_event: InputEvent) -> State:
	return null
	
func _player_damaged(hurt_box_in: HurtBox) -> void:
	hurt_box = hurt_box_in
	state_machine.change_state(self)
	pass
	
func _animation_finished(name: String) -> void:
	
	next_state = idle_state
	
