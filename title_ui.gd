extends Control

@onready var docIDLineEdit = $ConfigurationContainer/DocIDContainer/DocIDLineEdit;
@onready var configIDLineEdit = $ConfigurationContainer/ConfigIDContainer/ConfigIDLineEdit;
@onready var statusDisplayLabel = $ConfigurationContainer/StatusContainer/StatusDisplayLabel;
@onready var world = $"/root/NotWaitingForGodot/World";

func resetIDs():
	docIDLineEdit.text = "14qT2o_0n8Im94eKiRVjA4K4qozhorJw0Z95SlzhMxaM";
	configIDLineEdit.text = "1674844352";
	statusDisplayLabel.text = "---";

func _ready():
	resetIDs();
	
func _on_load_button_pressed():
	world.getConfiguration(docIDLineEdit.text,configIDLineEdit.text);

func setError(msg):
	statusDisplayLabel.text = "error: " + msg;
	push_error(msg);
	
func setLog(msg):
	statusDisplayLabel.text = msg;
	print(msg);

func _on_reset_ids_button_pressed():
	resetIDs();
