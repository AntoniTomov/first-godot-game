extends Camera2D

var player: Player = null;
var viewport_size;
var velocity = 0;

func _ready():
	viewport_size = get_viewport_rect().size; 
	global_position.x = viewport_size.x / 2;
	
	limit_bottom = viewport_size.y;
	
func _process(delta):
	if player:
		const limit_distance = 360;
		if limit_bottom > player.global_position.y + limit_distance:
			limit_bottom = player.global_position.y + limit_distance;

func setup_camera(_player: Player):
	if _player:
		player = _player;
	
func _physics_process(delta):
	if player:
		global_position.y = player.global_position.y;
	
