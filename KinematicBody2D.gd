extends KinematicBody2D

const UP = Vector2(0, -1)
var motion = Vector2()
export var speed = 200
export var gravity = 50
export var jumpForce = -700

func _physics_process(delta):
	motion.y += gravity
	if Input.is_action_pressed("ui_right"):
		motion.x = speed
	
	elif Input.is_action_pressed("ui_left"):
		motion.x = -speed
		
	else:
		motion.x = 0
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = jumpForce
	
	motion = move_and_slide(motion, UP)