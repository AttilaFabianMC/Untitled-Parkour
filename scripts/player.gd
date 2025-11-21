extends CharacterBody2D
@onready var jump = $jump
@onready var walljump2 = $Walljump2
@onready var walkingsound = $walkingsound
@onready var rc_left = $"Wall Jump rc left"
@onready var rc_right = $"Wall jump rc right"
@onready var move_dt = $"walljumpwait"

var SPEED = 100.0
var JUMP_VELOCITY = -300.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			jump.play()
		elif rc_left.is_colliding():
			velocity.y = JUMP_VELOCITY/1.1
			velocity.x = SPEED * 2.5
			move_dt.start(0.2)
			walljump2.play()
		elif rc_right.is_colliding():
			velocity.y = JUMP_VELOCITY/1.1
			velocity.x = -SPEED * 2.5
			move_dt.start(0.2)
			walljump2.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction and move_dt.is_stopped():
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 8)

	move_and_slide()
