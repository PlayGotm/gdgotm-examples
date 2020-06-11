extends Control

func _ready():
	$Menu.show()
	$Game.hide()


func _on_Host_clicked(instance):	
	$Menu.hide()
	$Game.show()
	$Game.host()


func _on_Join_clicked(instance):
	$Menu.hide()
	$Game.show()
	$Game.join()