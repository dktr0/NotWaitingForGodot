extends Control

func _on_button_pressed() -> void:
	reset();
	
func _on_timer_timeout() -> void:
	reset();
	
func run():
	visible = true;
	$Timer.start();

func reset():
	visible = false;
	$"../World".reset();
