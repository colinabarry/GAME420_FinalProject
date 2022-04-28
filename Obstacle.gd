extends Area2D

	
func set_sprite(sprite):
	$Sprite.texture = sprite
	$ObstacleExplosion.set_sprite()
