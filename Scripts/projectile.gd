class_name Projectile extends CharacterBody2D

@export var SPEED = 1000
var direction = Vector2.ZERO


func _physics_process(delta: float) -> void:
	velocity = direction * SPEED
	move_and_slide()
