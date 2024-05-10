extends Node2D

@onready var platform_parent = $PlatformParent


var power_up = preload("res://scenes/speed_power_up.tscn");
var static_platform = preload("res://scenes/static_platform.tscn");
var camera_scene = preload("res://scenes/camera_2d.tscn");
var platform_scene = preload("res://scenes/platform.tscn");
var player_scene = preload("res://scenes/player.tscn");
var rng = RandomNumberGenerator.new();
var player;

var camera = null;

#Level gen variable
var start_platform_y
var y_distance_between_platforms = 100;
var level_size = 50;
var next_step_y;
var previous_step_y = 0;

func _ready():
	camera = camera_scene.instantiate();
	camera.setup_camera($Player);
	add_child(camera);
	player = player_scene.instantiate();
	
	var viewport_size = get_viewport_rect().size;
	var platform_width = 155;
	var ground_layer_platform_count = (viewport_size.x / platform_width) + 1;
	
	#Generate the ground
	create_ground_layer(ground_layer_platform_count, platform_width);
	
	#Generate the rest of the level
	create_level(viewport_size, platform_width, ground_layer_platform_count);
	
func create_ground_layer(ground_layer_platform_count, platform_width):
	for i in range(ground_layer_platform_count):
		var ground_location = Vector2(i * platform_width, 0);
		create_platform(ground_location,true);
		
	
func create_level(viewport_size, platform_width, ground_layer_platform_count):
	var ground_layer_y_offset = 55;
	
	start_platform_y = viewport_size.y- (y_distance_between_platforms * 2);
	for i in range(level_size):
		var max_x_position = viewport_size.x - platform_width;
		var random_x_value = randf_range(0.0, max_x_position);
		next_step_y = randf_range(previous_step_y - (player.speed / 2), previous_step_y - player.speed);
		if next_step_y < previous_step_y - player.speed:
			next_step_y = previous_step_y - player.speed;
		var location: Vector2;
		location.x = random_x_value;
		location.y = next_step_y;
		previous_step_y = next_step_y;
		
		create_platform(location,false);
	
func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit();
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene();
	
	
func create_platform(location: Vector2, is_ground: bool):
	var vanishing_platform = static_platform.instantiate();
	var platform = platform_scene.instantiate();
	platform.global_position = location;
	vanishing_platform.global_position = location;
	print(location)
	
	var random_platform = randf_range(1, 100);
	
	
	if is_ground:
		platform_parent.add_child(platform);
	else:
		if random_platform > 40 and random_platform < 70:
			create_powerup(location);
		if random_platform < 67:
			platform_parent.add_child(platform);
		else:
			platform_parent.add_child(vanishing_platform);
	
func create_powerup(location):
		var power_up_inst = power_up.instantiate()
		var power_location = Vector2(location.x, location.y - 150)
		power_up_inst.global_position = power_location
		platform_parent.add_child(power_up_inst)
