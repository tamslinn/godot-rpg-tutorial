class_name EnemyStateDestroy extends EnemyState

@export var anim_name : String = "destroy"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0


var _damage_position : Vector2
var direction : Vector2

func init() -> void:
	enemy.enemy_destroyed.connect(_on_enemy_destroyed)
	
func enter() -> void:
	enemy.invulnerable = true
	
	direction = enemy.global_position.direction_to(_damage_position)
	enemy.set_direction(direction)
	enemy.velocity = direction * -knockback_speed
	
	enemy.update_animation(anim_name)
	enemy.animation_player.animation_finished.connect( _on_animation_finished)
	pass
	
func exit() -> void:
	enemy.invulnerable = false
	pass
	
func process(delta: float) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate_speed * delta
	return null
	
	
func physics(_delta: float) -> EnemyState:
	return null
	
func _on_enemy_destroyed(hurt_box: HurtBox) -> void:
	_damage_position = hurt_box.global_position
	state_machine.change_state( self )
	
func _on_animation_finished(_anim_name : String) -> void:
	enemy.animation_player.animation_finished.disconnect( _on_animation_finished)
	enemy.queue_free()
