extends CharacterBody2D


# Bewegung
@export var move_speed = glob_player.move_speed
@export var acceleration = glob_player.acceleration
@export var deceleration = glob_player.deceleration

# Springen
@export var jump_velocity = glob_player.jump_velocity
@export var gravity = glob_player.gravity
@export var max_jump_time = glob_player.max_jump_time
@export var jump_boost_velocity = glob_player.jump_boost_velocity

@export var fast_fall_multiplier = glob_player.fast_fall_multiplier       # Verstärkte Gravitation beim Runterfallen
@export var low_gravity_multiplier = glob_player.low_gravity_multiplier      # Weniger Gravitation beim Halten der Sprungtaste

@onready var sprite = $AnimatedSprite2D

var jump_time := 0.0
var is_jumping := false
var was_on_floor := false

func _physics_process(delta: float) -> void:
	var is_falling := velocity.y > 0 and not is_on_floor()

	# === GRAVITY ===
	if not is_on_floor():
		var applied_gravity = gravity

		if Input.is_action_pressed("ui_down"):
			# Schneller Fallen bei Runter-Taste
			applied_gravity *= fast_fall_multiplier
		elif Input.is_action_pressed("ui_accept"):
			# Weniger Gravitation beim Halten von Sprung
			applied_gravity *= low_gravity_multiplier

		velocity.y += applied_gravity * delta
	else:
		if not was_on_floor:
			sprite.play("land")
		is_jumping = false
		jump_time = 0.0

	# === LINKS / RECHTS ===
	var direction := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * move_speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration * delta)

	# === SPRINGEN ===
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
		is_jumping = true
		jump_time = 0.0
		sprite.play("jump")

	if Input.is_action_pressed("ui_accept") and is_jumping:
		if jump_time < max_jump_time:
			velocity.y += jump_boost_velocity * delta
			jump_time += delta
		else:
			is_jumping = false

	# === ANIMATION ===
	if not is_on_floor():
		if sprite.animation != "jump":
			sprite.play("jump")
	elif sprite.animation != "land":
		if direction != 0:
			sprite.play("run")
			sprite.flip_h = direction < 0
		else:
			sprite.play("idle")

	# === BEWEGUNG AUSFÜHREN ===
	move_and_slide()

	# === ZUSTAND FÜR LANDEN MERKEN ===
	was_on_floor = is_on_floor()
