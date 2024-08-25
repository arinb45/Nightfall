extends Node3D

@onready var can_on

func _ready():
	if active_weapon:
		$AnimationPlayer.play("equip")
		$equip.play()
		can_on = false

@onready var active_weapon = false
var on = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if active_weapon:
		if Input.is_action_just_pressed("fire"):
			ON()
		if Input.is_action_just_pressed("FlashlightOff"):
			OFF()

func isActive(state):
	if state == true:
		active_weapon = true
	else: 
		active_weapon = false
		
func ON():
	if can_on:
		if !on:
			$AnimationPlayer.play("on")
			$on.play()
			on = true
	
func OFF():
	if can_on:
		if on:
			$AnimationPlayer.play("off")
			$off.play()
			on = false


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "equip":
		can_on = true
