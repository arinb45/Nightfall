extends CharacterBody3D

var current_state = "idle"
var next_state = "idle"
var previous_state = "idle"
var Whealth = 500
var Rng = RandomNumberGenerator.new()
var powerUp = 0 
var inRange = false

@onready var player
@onready var bloodSpray = preload("res://BloodSpray.tscn")
@onready var shack 
var safe 

func _ready():
	player = get_tree().get_first_node_in_group("player")
	shack = get_tree().get_first_node_in_group("shack")
	print(player)
	
func _physics_process(delta):
	previous_state = current_state
	current_state = next_state
	safe = shack.check()
	match current_state:
		"idle":
			idle()
		"attack":
			attack()
		"run":
			run(delta)
		"scream":
			scream()
		"death":
			death()	
		"stun":
			stun(delta)
			
	if Whealth <= 60 && powerUp < 1:
		next_state = "scream"
		Whealth = 600
		WendigoSpeed = 8
		powerUp += 1
		
@onready var nav = $enemyNav
@onready var WendigoSpeed = 6.0
@onready var face_direction = $hit/faceDirection
@onready var turnSpeed = 2


func idle():
	next_state = "run"
	if previous_state != current_state:
		$AnimationPlayer.play("Idle")
		
func attack():
	if previous_state != current_state:
		$AnimationPlayer.play("Attack")
		await get_tree().create_timer(1).timeout
		$hit/AttackZone/Timer.start()
		if player.position.distance_to(self.position) < 8:
			if timeElapsed:
				player.takeDamage(25)
		$Attack.play()
		
func run(delta):
	if !safe:
		velocity = (nav.get_next_path_position() - position).normalized() * WendigoSpeed * delta
		face_direction.look_at(player.position, Vector3.UP)
		rotate_y(deg_to_rad(face_direction.rotation.y * turnSpeed))
		
		if player.position.distance_to(self.position) < 7:
			next_state = "attack"
		if player.position.distance_to(self.position) > 1:
			nav.target_position = player.position
			move_and_collide(velocity)
			$AnimationPlayer.play("Run")
			#$Run.play()
	else:
		velocity = Vector3.ZERO
		self.position.x = -117.7
		self.position.y = 0
		self.position.z = 119.27
	
func scream():
	if previous_state != current_state:
		$Scream.play()
		$AnimationPlayer.play("Scream")
		await get_tree().create_timer(3).timeout
		next_state = "run"
	
@export var wendigoDead: bool

func death():
	if previous_state != current_state:
		$AnimationPlayer.play("Death")
		wendigoDead = true
		await get_tree().create_timer(5).timeout
		position.y = 1000
		visible = false
		
func stun(delta):
	$AnimationPlayer.play("Stun")
	velocity = -(nav.get_next_path_position() - position).normalized() * WendigoSpeed * delta

func take_damage(num):
	#blood
	var blood = bloodSpray.instantiate()
	blood.emitting = true
	add_child(blood)
	var offset = Vector3(0,5,0)
	blood.position += offset
	Whealth -= num
	print(Whealth)
	var stunRng = Rng.randf_range(0.0,10.0)
	print(stunRng)
	if stunRng > 9.0:
		next_state = "stun"
	if Whealth <= 0:
		next_state = "death"

func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"Attack":
			next_state = "run"
	match anim_name:
		"Death":
			wendigoDead = true
	match anim_name:
		"Stun":
			next_state = "run"

var timeElapsed = false
func _on_timer_timeout():
	timeElapsed = true

func deathCheck():
	if wendigoDead:
		return true
	else: 
		return false

