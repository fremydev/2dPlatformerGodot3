extends Camera2D

var target_position: Vector2 = Vector2.ZERO
const GAMESIZE: Vector2 = Vector2(320, 180)
onready var window_scale: float = (OS.window_size / GAMESIZE).x
onready var actual_cam_pos: Vector2 = global_position

export(Color, RGB) var background_color

func _ready() -> void:
	VisualServer.set_default_clear_color(background_color)
	zoom = Vector2(1,1)


func _process(delta) -> void:
	acquire_target_position()
	
	actual_cam_pos = lerp(target_position, global_position, pow(2, -15 * delta))
	var subpixel_position = actual_cam_pos.round() - actual_cam_pos
	
	_global.viewport_container.material.set_shader_param("cam_offset", subpixel_position)

	global_position = actual_cam_pos.round()

func acquire_target_position() -> void:
	var players: Array = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		var player: Node = players[0]
		target_position = player.global_position
