extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var mirror_placeholder: Marker2D = $Mirror_placeholder
@onready var cristal_scene = preload("res://entities/cristal.tscn")
var array_of_cristals = []
var cristal_distance = 80

const SPEED = 50.0
const JUMP_VELOCITY = -180.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if is_on_floor():
		if direction > 0:
			anim.flip_h = false
			anim.play("walk")
		elif direction < 0:
			anim.flip_h = true
			anim.play("walk")
		else:
			anim.play("idle")
	else:
		anim.play("jump")
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("Create_Cristal"):
		CreateCristal()
	
	if Input.is_action_just_pressed("Remove_Cristal"):
		RemoveCristal()
 
	move_and_slide()
	
	
func CreateCristal():
	var cristal_instance = cristal_scene.instantiate()
	add_sibling(cristal_instance)
	cristal_instance.global_position = mirror_placeholder.global_position
	array_of_cristals.append(cristal_instance)

func RemoveCristal():
	if array_of_cristals.size() > 0:
		var cristal = array_of_cristals.pop_back()
		cristal.queue_free()
