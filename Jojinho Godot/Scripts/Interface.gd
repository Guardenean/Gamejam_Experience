extends Control

func _on_jogar_pressed():
	get_tree().change_scene_to_file("res://Cenas/Fase.tscn")
	
func _on_sair_pressed():
	get_tree().quit()
	
func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Cenas/Import/NeoInterface.tscn")
