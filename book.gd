extends Node3D

@onready var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	read()

var readZone = false

func _on_read_body_entered(body):
	if body.is_in_group("player"):
		readZone = true
		$text.visible = true

func _on_read_body_exited(body):
	if body.is_in_group("player"):
		readZone = false
		$text.visible = false

func read():
	if readZone:
		return true
	else: 
		return false
