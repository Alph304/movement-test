extends Node2D

var in_dialogue

func _ready():
	$Label.hide()

func _on_player_dialogue():
	in_dialogue = true

func _process(delta):
	if in_dialogue:
		$Label.show()
		if !get_node("player/ShapeCast2D").is_colliding() or Input.is_action_just_pressed("action"):
			$Label.hide()
			in_dialogue = false
