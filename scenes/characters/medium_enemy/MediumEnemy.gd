extends Enemy

var arrival_zone_radius: int = 20

# onready var raycasts: Node2D = get_node("Raycasts")


func _physics_process(_delta) -> void:
	look_at(player.position)

	if (position - player.position).length() > arrival_zone_radius:
		chase()
		move()
	else:
		orbit()


func lunge() -> void:
	print("Attack!")


# Called when the enemy's PlayerDetector detects another Area2D entering it
func _on_PlayerDetector_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		print("Attack!")
