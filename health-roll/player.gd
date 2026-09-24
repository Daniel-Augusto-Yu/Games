extends CharacterBody2D
var speed = 500
var roll_speed = 800
var direction = Vector2.ZERO
var is_rolling: bool = false
var time = 0


signal HealthChanged

@export var MaxHealth = 10
@onready var CurrentHealth: int = 5


func _ready() -> void:
	$AnimatedSprite2D.animation_finished.connect(_on_animation_finished)

func _physics_process(delta: float) -> void:
	if is_rolling:
		move_and_slide()
		return
		
	direction = Input.get_vector("left","right","up","down")
	time -= 1
	
	if direction != Vector2.ZERO and Input.is_action_just_pressed("Roll") and time < 0:
		start_roll()
	else:
		
		velocity = direction * speed
		move_and_slide()
		animation()
		
func start_roll():
	is_rolling = true
	velocity = roll_speed * direction
	$AnimatedSprite2D.play("roll")
	time = 15
	
func animation():
	if direction:
		if direction.x:
			$AnimatedSprite2D.play("Right")
			if direction.x < 0: $AnimatedSprite2D.flip_h = true
			else: $AnimatedSprite2D.flip_h = false
		if direction.y:
			if direction.y < 0: $AnimatedSprite2D.animation = "Up" 
			else: $AnimatedSprite2D.play("Down")
	else: $AnimatedSprite2D.play("idle")

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if is_rolling:
		return
	else:	
		CurrentHealth -= 1
		if CurrentHealth < 0:
			CurrentHealth = MaxHealth
	
		HealthChanged.emit(CurrentHealth)
		
func _on_animation_finished():
	if $AnimatedSprite2D.animation == "roll":
		is_rolling = false
