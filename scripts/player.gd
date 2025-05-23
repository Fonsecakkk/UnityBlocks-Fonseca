extends CharacterBody2D

func _enter_tree() -> void:#multiplayer 2
	set_multiplayer_authority(name.to_int())
	
const SPEED = 100.0
const JUMP_FORCE = -250.0
const JUMP_VELOCITY = -300


@onready var animation := $Animation as AnimatedSprite2D
var is_jumping := false

@onready var camera := $"../../CameraFollow"

func _ready():
	add_to_group("players")  # Adiciona automaticamente ao grupo "players"



func _physics_process(delta: float) -> void:
	if is_multiplayer_authority(): #multiplayer 2
		velocity = Input.get_vector("ui_left","ui_right","ui_up","ui_down") * 400
	move_and_slide()
	
	for platforms in get_slide_collision_count():
		var collision = get_slide_collision(platforms)
		if collision.get_collider().has_method("has_collided_with"):
			collision.get_collider().has_collided_with(collision, self)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE
		is_jumping = true
	elif is_on_floor():
		is_jumping = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		animation.play("run")
		animation.scale.x = direction
		if !is_jumping:
			animation.play("run")
		elif is_jumping:
			animation.play("jump")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation.play("idle")
		
	move_and_slide()
	
func respawn():
	var respawn_point = get_tree().get_nodes_in_group("spawn")[0]
	if respawn_point:
		position = respawn_point.position



#inimigo 
var vida = 1
var morto = false

func morrer():
	$Animation.play("morrer")
	set_deferred("monitoring", false)
	set_deferred("collision_layer", 0)
	set_deferred("collision_mask", 0)
	await $Animation.animation_finished
	queue_free()

		
func _on_DamageArea_body_entered(body):
	if body.is_in_group("players"):  # Verifica se o objeto está no grupo "players"
		if body.has_method("morrer"):
			body.morrer()  # Chama a função de morrer no player
