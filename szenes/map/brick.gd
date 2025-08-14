extends StaticBody2D

@onready var sprite = $AnimatedSprite2D
@onready var collisoinShape = $CollisionShape2D
@onready var area2d = $Area2D


var triggered := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.animation = "default"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player" and triggered == false:
		triggered = true
		if sprite.animation == "default":
			sprite.animation = "cracked"
		elif sprite.animation == "cracked":
			sprite.animation = "opend"
			collisoinShape.queue_free()
			area2d.queue_free()
			
		triggered = false
		
