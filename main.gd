extends CanvasLayer

var counter = 0

const WORLD = preload("res://Intro.tscn")

func _ready():
	$AnimationPlayer.play("intro")

func _on_quit_button_pressed():
	get_tree().quit()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Intro.tscn")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "intro":
		counter +=1
		$AnimationPlayer.play("intro")

@warning_ignore("unused_parameter")
@onready var camera = $Background/SubViewportContainer/SubViewport/Camera3D
func _process(delta):
	if counter > 0:
		$black.visible = false

func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
