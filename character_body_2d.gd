extends CharacterBody2D

var speed = 300
var screen_size
signal dialogue



func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	var collision = move_and_collide(velocity * delta)
	
	
	if direction.y < 0:
		$AnimatedSprite2D.animation = "up"
		$ShapeCast2D.rotation = deg_to_rad(180)
		$ShapeCast2D.scale = Vector2(2.0, 0.6)
	elif direction.y > 0:
		$AnimatedSprite2D.animation = "down"
		$ShapeCast2D.rotation = deg_to_rad(0.0)
		$ShapeCast2D.scale = Vector2(2.0, 0.6)
	elif direction.x != 0:
		$AnimatedSprite2D.animation = "right"
		$ShapeCast2D.rotation = deg_to_rad(-90)
		$ShapeCast2D.scale = Vector2(2.3, 0.6)
		$AnimatedSprite2D.flip_h  = direction.x < 0
		if direction.x < 0:
			$ShapeCast2D.rotation = deg_to_rad(90)
			$ShapeCast2D.scale = Vector2(2.3, 0.6)
	

	
	if direction.length() != 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

func _process(delta: float) -> void:
	if $ShapeCast2D.is_colliding():
		if $ShapeCast2D.get_collider(0).name == "NPC" and Input.is_action_just_pressed("action"):
			dialogue.emit()

	
	position = position.clamp(Vector2.ZERO, screen_size)
