extends KinematicBody
export var is_player = true

#variaveis de controle de personagem
export var speed = 10
export var rot_speed = 2
export var gravityValue = 1

var velocity = Vector3()

var can_move = true

func _ready():
	pass


func get_input():
	#vetor velocidade(aplicando velocity dessa forma para poder girar no eixo correto com rotated
	if Input.is_action_pressed("ui_up") and can_move:
		velocity = Vector3(0,velocity.y,-speed).rotated(Vector3(0,1,0),deg2rad(rotation_degrees.y))
	elif Input.is_action_pressed("ui_down")and can_move:
		velocity = Vector3(0,velocity.y,speed).rotated(Vector3(0,1,0),deg2rad(rotation_degrees.y))
	else:
		velocity = Vector3(0,velocity.y,0).rotated(Vector3(0,1,0),deg2rad(rotation_degrees.y))
		
	#rotação
	if Input.is_action_pressed("ui_right")and can_move:
		rotation_degrees.y -= rot_speed
	elif Input.is_action_pressed("ui_left")and can_move:
		rotation_degrees.y += rot_speed


func _process(_delta):
	gravity()
	get_input()
	velocity = move_and_slide_with_snap(velocity, Vector3.DOWN,Vector3.UP, true)
	var normal = $RayCast.get_collision_normal()
	var xform = align_with_y(global_transform, normal)
	global_transform = global_transform.interpolate_with(xform, 0.2)

func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform


func gravity():
	if not is_on_floor():
		velocity.y -= gravityValue
	else:
		velocity.y = -1

