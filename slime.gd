extends Node2D

const SPEED = 30

var direction = 1
var death = false
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if death:
		return
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	
	position.x += direction * SPEED * delta


func _on_area_2d_body_entered(body):
	if body.is_in_group("players"):
		body.velocity.y = body.JUMP_VELOCITY
		print("matou")
		death = true
		$morte/CollisionShape2D.queue_free() 
		$Killzone/CollisionShape2D.queue_free() 
		animated_sprite.play("slimedeath")
		await animated_sprite.animation_finished
		queue_free()
		
