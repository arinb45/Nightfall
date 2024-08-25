extends Node3D

@onready var player = $player
@onready var wendigo = $"wendigo-col1"
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("start")
	$details/campfires.play()
	sun()
	active()

var Rng = RandomNumberGenerator.new()

@warning_ignore("unused_parameter")
func _process(delta):
	if wendigo.deathCheck():
		$AnimationPlayer.play("end")
	if player.returnStatus():
		wendigo.position.y = -5
		wendigo.visible = false
		get_tree().change_scene_to_file("res://scenes/death_screen.tscn")

func sun():
	$sun/AnimationPlayer.play("Day-Night")

var can_howl = true

func howl():
	if can_howl:
		$whistle.play()
		can_howl = false
		
func _on_whistle_finished():
	can_howl = true


func _on_timer_timeout():
	var chance = Rng.randf_range(0,8)
	if chance >= 7:
		howl()
		print(chance)


func _on_fire_2_body_entered(body):
	if body.is_in_group("player"):
		player.takeDamage(10)


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "end":
		get_tree().change_scene_to_file("res://scenes/ending.tscn")


func _on_music_finished():
	$music.play()


func _on_ambience_finished():
	$ambience.play()

func active():
	$"wendigo-col1".position.x = -117.7
	$"wendigo-col1".position.y = 2.593
	$"wendigo-col1".position.x = 119.27
	$"wendigo-col1".visible = true
