extends Spatial

var player;
var camera;

func _ready():
	addPlayer();

func _physics_process(_delta):
	pass;

func addPlayer():
	player = KinematicBody.new();
	player.name = "Player";
	camera = Camera.new();
	player.add_child(camera);
	add_child(player);
	print("addPlayer completed");
