extends Enemy

var arrival_zone_radius: int = 20

onready var raycasts: Node2D = get_node("Raycasts")

func _physics_process(_delta) -> void:
	look_at(player.position)
	
	if (position - player.position).length() > arrival_zone_radius:
		chase()
		move()
	else:
		orbit()

func _on_PlayerDetector_body_entered(body):
	print("Attack!")

func lunge() -> void:
	print("Attack!")
