extends CharacterBody3D

@onready var agent = $NavigationAgent3D
var speed = 1
var targ: Vector3

var rng = RandomNumberGenerator.new()

func _ready():
	set_physics_process(false)
	await get_tree().physics_frame
	set_physics_process(true)
	rng.randomize()
	targ = Vector3(randf_range(-45,45),0,randf_range(-45,45))
	updateTargetLocation(targ)
	
func _physics_process(delta):
	look_at(targ)
	rotation.x = 0
	rotation.y = 0
	
	if position.distance_to(targ) > 0.5:
		var curloc = global_transform.origin
		var nextloc = agent.get_next_path_position()
		var newVel = (nextloc - curloc).normalized() * speed
		targ.y = position.y
		velocity = newVel
		move_and_slide()
	else:
		rng.randomize()
		targ = Vector3(randf_range(-5,5),0,randf_range(-5,5))
		updateTargetLocation(targ)
func updateTargetLocation(target):
	agent.set_target_position(target)
