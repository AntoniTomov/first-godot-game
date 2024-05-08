extends CharacterBody2D
class_name Player;

@onready var animator = $AnimationPlayer

var viewport_size;

var speed = 300.0;

var gravity = 15.0;
var max_fall_velocity = 1000.0;
var jump_velocity = -800;
var last_platform_touched_y = 0;

func _ready():
	viewport_size = get_viewport_rect().size;
	global_position.x = viewport_size.x / 2


func _process(delta):
	if velocity.y > 0:
		if animator.current_animation != "fall":
			animator.play("fall");
	elif velocity.y < 0:
		if animator.current_animation != "jump":
			animator.play("jump");

func _physics_process(delta):
	velocity.y += gravity;
	if velocity.y > max_fall_velocity:
		velocity.y = max_fall_velocity;
	if velocity.y == 0:
		velocity.y -= gravity;
		
	if velocity.y > viewport_size.y / 2.5:
		velocity.y += gravity;
	
	var dir = Input.get_axis("move_left", "move_right");
	if dir:
		velocity.x = dir * speed;
	else:
		velocity.x = move_toward(velocity.x, 0, speed);
	move_and_slide();

	var margin = 20;

	if global_position.x > viewport_size.x + margin:
		global_position.x = -margin;
		
	if global_position.x < -margin:
		global_position.x = viewport_size.x + margin;

func jump():
	velocity.y = jump_velocity;



func _on_visible_on_screen_notifier_2d_screen_exited():
	get_tree().reload_current_scene();
	
