extends KinematicBody2D

export var EnemySpeed = 40
export var Gravity = 10

var EnemyMotion = Vector2()
var EnemyDirection = 1
var UP = Vector2(0,-1)
var OppositeDirection = -1


func _ready():
	set_physics_process_internal(true)
	
func _physics_process(delta):
	
	EnemyMotion.y += Gravity
	
	if is_on_wall() or $RayCast2D.is_colliding() == false:
		EnemyDirection = EnemyDirection * OppositeDirection
		$RayCast2D.scale.x *=-1
	
	if EnemyDirection == 1:
		$Sprite.flip_h = false
		$RayCast2D.scale.x *=-1
	elif EnemyDirection == -1:
		$Sprite.flip_h = true
		$RayCast2D.scale.x *=-1
		EnemyDirection = EnemyDirection + OppositeDirection

	EnemyMotion.x = EnemyDirection * EnemySpeed
	EnemyMotion = move_and_slide(EnemyMotion, UP)