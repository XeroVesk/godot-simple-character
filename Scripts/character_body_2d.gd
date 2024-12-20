extends CharacterBody2D
const projectile_scene = preload("res://Scenes/projectile.tscn")

@export var SPEED      = 300.0
@export var COOLDOWN = 0.2
var current_cooldown = 0


func _physics_process(delta: float) -> void:
	handle_player_input()
	handle_cooldown_change(delta)
	return
	
func handle_player_input() -> void:
	handle_player_movement()
	handle_player_attack()
	return	

func handle_player_movement() -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction.normalized() * SPEED;
	move_and_slide()
	return
	
func handle_player_attack() -> void:
	if Input.is_action_pressed("attack") and current_cooldown == 0:
		# Spawn two projectiles in
		var projectile = spawn_projectile(global_position + Vector2(50, -90))
		projectile.direction = calculate_direction(projectile.global_position, get_global_mouse_position())
		
		var projectile2 = spawn_projectile(global_position + Vector2(-50, -90))
		projectile2.direction = calculate_direction(projectile2.global_position, get_global_mouse_position())
		
		current_cooldown = COOLDOWN # Put attack on cooldown
	return
	
func calculate_direction(starting_position: Vector2, end_position: Vector2) -> 	Vector2:
	return (end_position - starting_position).normalized()

	# Instantiates projectile and sets its position
func spawn_projectile(projectile_position: Vector2) -> Projectile:
	var projectile: Projectile = projectile_scene.instantiate()
	get_parent().add_child(projectile)
	projectile.global_position = projectile_position
	return projectile

func handle_cooldown_change(delta: float) -> void:
	if current_cooldown <= delta:
		current_cooldown = 0;
	else:
		current_cooldown -= delta
