extends CharacterBody2D

func _ready():
	$Head.connect("body_entered", Callable(self, "_on_head_entered"))
	$Body.connect("body_entered", Callable(self, "_on_body_entered"))
	$DamageArea.connect("body_entered", Callable(self, "_on_DamageArea_body_entered"))

func _on_head_entered(body):
	if body.is_in_group("players"):
		morrer()

func _on_body_entered(body):
	if body.is_in_group("players"):
		body.morrer()  # Faz o personagem morrer

func morrer():
	$AnimatedSprite2D.play("morrer")  # Toca animação de morte
	$Head.set_deferred("monitoring", false)
	$Body.set_deferred("monitoring", false)
	await $AnimatedSprite2D.animation_finished
	queue_free()  # Remove o inimigo da cena


func _on_area_2d_head_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		morrer()




func _on_area_2d_body_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		body.morrer()  # Faz o personagem morrer







const speed = 30.0

	
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@export var left_limit: float = -100
@export var right_limit: float = 100

var direction = 1

func _process(delta):
	position.x += speed * direction * delta
	if position.x > right_limit:
		direction = -1
		$AnimatedSprite2D.flip_h = true  # Vira o sprite
	elif position.x < left_limit:
			direction = 1
			$AnimatedSprite2D.flip_h = false


func _on_damage_area_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _physics_process(delta):
	if $RayCastRight.is_colliding():
		direction = -direction
		$RayCast2Left.position.x *= -1  # Espelha o RayCast para o outro lado
		move_and_slide()

func _on_wall_collision():
	direction = -direction  # Inverte a direção quando bate na parede
