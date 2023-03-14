extends CharacterBody2D


export(PackedScene) var Shoot


const SPEED = 100.0
onready var motion = Vector2.ZERO # Es lo mismo que poner Vecto2(0 ,0)
onready var can_shoot : bool = true
onready var screensize = get_viewport_rect().size # Tamao de nuestra ventana


func _ready():
	$AnimatedSprite2D.play()


func _physics_process(delta):
	motion_ctrl()
	animation_ctrl()
	motion = move_and_collide(motion * delta)

func _input(event):
	if event.is_action_pressed("ui_accept") and can_shoot:
		shoot_ctrl()


func get_axis() -> Vector2: # Obtener ejes
	var axis = Vector2.ZERO # Es lo mismo que poner Vecto2(0 ,0)
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_just_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis


func motion_ctrl(): # Controlador de movimiento
	if get_axis() == Vector2.ZERO:
		motion = Vector2.ZERO
	else: 
		motion = get_axis().normalized() * SPEED
	
	# Limitar movimiento del personaje
	position.x = clamp(position.x, 0, screenzise.x)
	position.y = clamp(position.y, 0, screensize.y)


func animation_ctrl(): # Controlador de animaciones
	if get_axis().x == 1:
		$AnimatedSprite2D.animation = "Horizontal"
		$AnimatedSprite2D.flip_h = true
	elif get_axis().x == -1:
		$AnimatedSprite2D.animation = "Horizontal"
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.animation = "Vertical"


func shoot_ctrl(): # Controlador de disparos
	var shoot = Shoot.instance()
	shoot.global_position = $ShootSpawn.global_position
	get_tree().call_group("level", "add_child", shoot)
