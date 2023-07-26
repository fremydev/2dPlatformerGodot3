extends Camera2D

var target_position: Vector2 = Vector2.ZERO
const BGCOLOR: Color = Color( 0.87451, 0.964706, 0.960784, 1 )

func _ready() -> void:
	VisualServer.set_default_clear_color(BGCOLOR)


func _process(delta):
	acquire_target_position()
	global_position = lerp(target_position, global_position, pow(2, -40 * delta))


func acquire_target_position() -> void:
	var players: Array = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		var player: Node = players[0]
		target_position = player.global_position
