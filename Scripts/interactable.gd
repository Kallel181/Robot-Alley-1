extends StaticBody

export var text=["somente um bloco vermelho de testes"]

var current_text_id = 0

var is_in = false
var body_in = null

var interacting = false

func _process(_delta):
	var CameraLabel = get_node("../"+str(ActiveCamera.active_camera)+"/Camera/Control/Label")
	
	#checando se o objeto já foi colocado antes da checagem(evitar a checagem de Null)
	if body_in != null:
		if Input.is_action_just_pressed("ui_interact") and is_in and not interacting:
			body_in.can_move = false
			interacting = true
			CameraLabel.text = text[current_text_id]

		if interacting and current_text_id < len(text)-1 and Input.is_action_just_pressed("ui_enter"):
			current_text_id +=1
			CameraLabel.text = text[current_text_id]

		elif interacting and current_text_id == len(text)-1 and Input.is_action_just_pressed("ui_enter"):
			current_text_id=0
			body_in.can_move = true
			interacting = false
			CameraLabel.text = ""


#sinais
func _on_Area_body_entered(body):
	if body.has_method("gravity"):#mudar isso pra outra coisa(mas assim já funciona)
		is_in = true
		body_in = body


func _on_Area_body_exited(body):
	if body.has_method("gravity"):#mudar isso pra outra coisa(mas assim já funciona)
		is_in = false
		body_in = body

