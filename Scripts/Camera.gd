extends Spatial


func _on_Area_body_entered(body):
	if body.has_method("get_input"):
		get_node("Camera").current=true
		ActiveCamera.active_camera = name
		print(ActiveCamera.active_camera)


func _on_Area_body_exited(body):
	if body.has_method("get_input"):
		get_node("Camera").current=false

