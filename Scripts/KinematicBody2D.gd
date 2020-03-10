extends KinematicBody2D

signal killed()

const UP = Vector2(0,-1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = -550

export (float) var max_health = 100

onready var health = max_health setget _set_health
onready var invulnerability_timer = $InvulnerabilityTimer

var motion = Vector2()

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x +ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x -ACCELERATION, -MAX_SPEED)
		motion.x = -ACCELERATION
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
		$Sprite.play("Idle")
		friction = true
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
		
	else:
		if motion.y < 0:
			$Sprite.play("Jump")
	
	move_and_slide(motion, UP)
	pass

func damage(amoount):
	if invulnerability_timer.is_stopped():
		invulnerability_timer.start()
	

func kill():
	pass

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		if health == 0:
			kill()
			emit_signal("killed")