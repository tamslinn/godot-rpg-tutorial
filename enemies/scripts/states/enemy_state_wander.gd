class_name EnemyStateWander extends EnemyState

@export var anim_name : String = "walk"
@export var wander_speed : float = 20.0

@export_category("AI")
@export var state_animation_duration : float = 0.7
@export var anim_cycles_min : int = 1
@export var anim_cycles_max : int = 3


@export var after_wander_state : EnemyState

var _timer : float = 0.0
var direction : Vector2

func init() -> void:
	pass
	
func enter() -> void:
	print("entering wander")
	_timer = randi_range(anim_cycles_min, anim_cycles_max) * state_animation_duration
	var rand = randi_range(0,3)
	direction = enemy.directions[rand]
	enemy.velocity = direction * wander_speed
	enemy.set_direction(direction)
	enemy.update_animation(anim_name)
	pass
	
func exit() -> void:
	pass
	
func process(delta: float) -> EnemyState:
	_timer -= delta
	if _timer <= 0:
		return after_wander_state
	return null
	
	
func physics(_delta: float) -> EnemyState:
	return null
