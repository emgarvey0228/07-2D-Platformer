extends KinematicBody2D

export var EnemySpeed = 40
export var Gravity = 10

var EnemyMotion = Vector2()
var EnemyDirection = 1
var UP = Vector2(0, -1)
var OppositeDirection = -1


func _ready():
	set_physics_process_internal(true)
	
func _physics_process(delta):
	EnemyMotion.y += Gravity
	
	if is_on_wall():
		EnemyDirection = EnemyDirection * OppositeDirection
	
	if EnemyDirection == 1:
		$Sprite.flip_h = false
	elif EnemyDirection == -1:
		$Sprite.flip_h = true
		EnemyDirection = EnemyDirection + OppositeDirection

	EnemyMotion.x = EnemyDirection * EnemySpeed
	EnemyMotion = move_and_slide(EnemyMotion, UP)
	
#Make a second enemy 
#Figure out how to loop the music
#Add a score 50 points when you get to the brain and die when you hit zombie 
#Fix zombie walk
#Save and load! 