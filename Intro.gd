extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(1).timeout
	$AnimationPlayer.play("cutscene")


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	pass


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "cutscene":
		get_tree().change_scene_to_file("res://scenes/objective_1.tscn")
