extends Node2D


func _ready():
	$BgMusic.play()


"""Se ejecuta cada vez en cada fotograma con una velocidad 
de fotogramas constante que por defecto esta establecido en 
60 fotogramas"""
func _physics_process(delta):
	get_node("Background").scroll_base_offset += Vector2(0, 1) * 8 * delta
	get_node("Cloud01").scroll_base_offset += Vector2(0, 1) * 24 * delta
	get_node("Cloud02").scroll_base_offset += Vector2(0, 1) * 34 * delta
