extends Node3D

var docID;
var configID;
var worldID;
var configuration = {};
var playerStartX;
var playerStartY;
var playerStartZ;
var mode;
var cachedMap = "";
@onready var worldRequest = $"../WorldRequest";
@onready var configurationRequest = $"../ConfigurationRequest";
var gridScale = 2;
@onready var ui = $"../TitleUI";
@onready var player = $"/root/NotWaitingForGodot/Player";

func _physics_process(_delta):
	if Input.is_action_just_pressed("fullscreen"):
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (!((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN))) else Window.MODE_WINDOWED;
	elif Input.is_action_just_pressed("reset"):
		reset();
	elif Input.is_action_just_pressed("update"):
		loadOrUpdate();
	elif Input.is_action_just_pressed("playerStartHack"):
		playerToStartPosition();

func googleDocCSV(docID,sheetID):
	return "https://docs.google.com/spreadsheets/d/" + docID + "/gviz/tq?gid=" + sheetID + "&tqx=out:csv";
	
func getConfiguration(newDocID,newConfigID):
	docID = newDocID;
	configID = newConfigID;
	configurationRequest.connect("request_completed", Callable(self, "_receivedConfiguration"));
	var url = googleDocCSV(docID,configID);
	var error = configurationRequest.request(url);
	if error != OK:
		ui.setError("error in HTTP request for configuration (possibly bad document or configuration IDs), url=" + url);
	else:
		ui.setLog("requesting configuration sheet... url=" + url);

func _receivedConfiguration(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		ui.setError("error receiving configuration: " + str(result) + " " + str(response_code)+ " " + str(headers) + " " + str(body));
		return;
	else:
		ui.setLog("configuration sheet received")
	var txt = body.get_string_from_utf8();
	var rows = txt.split("\n");
	for rowNo in rows.size():
		var cols = rows[rowNo].split(",");
		var key = cols[0].substr(1,cols[0].length()-2);	
		var value = cols[1].substr(1,cols[1].length()-2);
		configuration[key] = value;
	playerStartX = float(configuration.get("PlayerStartX",0));
	playerStartY = float(configuration.get("PlayerStartY",0));
	playerStartZ = float(configuration.get("PlayerStartZ",0));
	mode = int(configuration.get("Mode",0));
	if configuration.has("WorldSheet"):
		worldID = configuration["WorldSheet"];
		getWorld(googleDocCSV(docID,worldID));
	else:
		ui.setError("no WorldSheet ID found in configuration (possibly problem in configuration sheet, possibly bad IDs above)");
	
func playerToStartPosition():
	player.playerStart(playerStartX,playerStartY,playerStartZ);

func getWorld(url):
	worldRequest.connect("request_completed", Callable(self, "_receivedWorld"));
	var error = worldRequest.request(url);
	if error != OK:
		ui.setError("error in HTTP request for world (possibly bad world sheet ID in configuration sheet)");
	else:
		ui.setLog("requesting world sheet...");
	
func _receivedWorld(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		ui.setError("error receiving world: " + str(result) + " " + str(response_code)+ " " + str(headers) + " " + str(body));
	else:
		ui.setLog("world sheet received");
		cachedMap = body.get_string_from_utf8();
		print(cachedMap)
		reset();

func loadOrUpdate():
	print("World::loadOrUpdate()");
	getConfiguration(docID,configID);
	
func reset():
	print("World::reset()");
	deleteWorld();
	loadCSVMap(cachedMap);
	playerToStartPosition();
	ui.hide();
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);

func gameOver():
	$"../SoundBank".laser();
	reset();

func deleteWorld():
	for i in range(0, get_child_count()):
		get_child(i).queue_free()

func makeGrassStoneWater(aspects):
	var factory;
	var baseFactory;
	if aspects["substance"] == "water":
		factory = preload("res://WaterWall.tscn");
		baseFactory = preload("res://models/nwfgwaterbase.tscn");
	elif aspects["substance"] == "stone":
		factory = preload("res://models/nwfgstonewall.tscn");
	else:
		factory = preload("res://models/nwfggrasswall.tscn");
	var x = aspects["x"];
	var y = aspects["y"];
	var z = aspects["z"];
	var h = aspects["h"];
	var nn;
	if mode != 2:
		nn = h + 1;
	else:
		nn = 1;
	for n in nn:
		var sb;
		if n == h && baseFactory != null:
			sb = baseFactory.instantiate();
		else:
			sb = factory.instantiate();
		if mode != 2:
			sb.position = Vector3(x,n*2,z);
		else:
			sb.position = Vector3(x,y,z);
		realizeStuff(aspects,sb);
		add_child(sb);
	
func makeABeam(aspects):	
	var scene = preload("res://Beam.tscn");
	var beam = scene.instantiate();
	beam.aspects = aspects;
	var y = aspects["y"] + (aspects["h"] * gridScale + gridScale);
	beam.position = Vector3(aspects["x"],y,aspects["z"]);
	realizeStuff(aspects,beam);
	add_child(beam);
	
func makeADoor(aspects):
	var scene = preload("res://models/Door.tscn");
	var door = scene.instantiate();
	var y = aspects["y"] + (aspects["h"] * gridScale + gridScale);
	door.position = Vector3(aspects["x"],y,aspects["z"]);
	door.add_to_group("doors");
	realizeStuff(aspects,door);
	add_child(door);
	
func makeAKey(aspects):
	var scene = preload("res://models/Key.tscn");
	var key = scene.instantiate();
	var y = aspects["y"] + (aspects["h"] * gridScale + gridScale);
	key.position = Vector3(aspects["x"],y,aspects["z"]);
	key.add_to_group("keys");
	realizeStuff(aspects,key);
	add_child(key);

func makeAnObelisk(aspects):
	var scene = preload("res://models/Obelisk.tscn");
	var o = scene.instantiate();
	var y = aspects["y"] + (aspects["h"] * gridScale + gridScale);
	o.position = Vector3(aspects["x"],y,aspects["z"]);
	realizeStuff(aspects,o);
	add_child(o);
	
func makeATeleportTo(aspects):
	print("makeATeleportTo");
	var scene = preload("res://teleporter.tscn");
	var t = scene.instantiate();
	var y = aspects["y"] + (aspects["h"] * gridScale + gridScale);
	t.position = Vector3(aspects["x"],y,aspects["z"]);
	t.targetID = aspects["teleportto"];
	t.add_to_group("teleportto");
	realizeStuff(aspects,t);
	add_child(t);

func makeATeleportFrom(aspects):
	print("makeATeleportFrom")
	var scene = preload("res://teleporter.tscn");
	var t = scene.instantiate();
	var y = aspects["y"] + (aspects["h"] * gridScale + gridScale);
	t.position = Vector3(aspects["x"],y,aspects["z"]);
	t.add_to_group("teleportfrom_" + aspects["teleportfrom"]);
	realizeStuff(aspects,t);
	add_child(t);
	
func movableBlock(aspects):
	print("movableBlock" + str(aspects));
	var scene = preload("res://MovableCube.tscn");
	var mc = scene.instantiate();
	mc.axis_lock_angular_x = true;
	mc.axis_lock_angular_y = true;
	mc.axis_lock_angular_z = true;
	if aspects["movableBlock"]=="xz":
		mc.axis_lock_linear_y = true;
	elif aspects["movableBlock"]=="x":
		mc.axis_lock_linear_y = true;
		mc.axis_lock_linear_z = true;
	elif aspects["movableBlock"]=="z":
		mc.axis_lock_linear_y = true;
		mc.axis_lock_linear_x = true;
	var y = aspects["y"] + (aspects["h"] * gridScale + gridScale);
	mc.position = Vector3(aspects["x"],y,aspects["z"]);
	mc.set_mass(1);
	mc.set_linear_damp(5); 
	realizeStuff(aspects,mc);
	add_child(mc);
	
#func loadCSVMapFile(path="res://map.txt"):
#	print("loading CSV map called " + path);
#	var file = File.new();
#	file.open(path, File.READ);
#	var map = file.get_as_text();
#	loadCSVMap(map);
	
func loadCSVMap(map=""):
	var rows = map.split("\n");
	for rowNo in rows.size():
		csvMapRow(rows[rowNo],rowNo,rows.size());

func csvMapRow(row,rowNo,nRows):
	print("csvMapRow rowNo " + str(rowNo));
	print(" " + str(row));
	var cells = row.split(",");
	for cellNo in cells.size():
		if mode == 2: # side-scroller
			var x = 2.0 * float(cellNo);
			var y = (2.0 * nRows - 2.0) - (2.0 * float(rowNo));
			csvMapCell(x,y,0,cells[cellNo]);		
		else:
			var x = 2.0 * float(cellNo);
			var z = 2.0 * float(rowNo);
			csvMapCell(x,0,z,cells[cellNo]);
		
func csvMapCell(x,y,z,cell=""):
	cell = cell.to_lower();
	cell = cell.substr(1,cell.length()-2);	# remove quotation marks at beginning and end of cell
	var aspects = { "substance": "grass", "h": 0, "x": x, "y": y, "z": z };
	if mode == 2:
		aspects.substance = "hole";
	var codes = cell.split(" ",false);
	for codeNo in codes.size():
		parseCode(codes[codeNo],aspects);
	realizeAspects(aspects);
		
func parseCode(code,aspects):
	if code == "1":
		aspects["h"] = 1;
	elif code == "2":
		aspects["h"] = 2;
	elif code == "3":
		aspects["h"] = 3;
	elif code == "4":
		aspects["h"] = 4;
	elif code == "5":
		aspects["h"] = 5;
	elif code == "6":
		aspects["h"] = 6;
	elif code == "7":
		aspects["h"] = 7;
	elif code == "8":
		aspects["h"] = 8;
	elif code == "9":
		aspects["h"] = 9;
	elif code == "w":
		aspects["substance"] = "water";
	elif code == "s":
		aspects["substance"] = "stone";
	elif code == "g":
		aspects["substance"] = "grass";
	elif code == "h":
		aspects["substance"] = "hole";
	elif code == "obelisk":
		aspects["obelisk"] = true;
	elif code == "key":
		aspects["key"] = true;
	elif code == "door":
		aspects["door"] = true;
	elif (code == "movable" || code == "moveable"):
		aspects["movableBlock"] = "xz";
	elif (code == "movablex" || code == "moveablex"):
		aspects["movableBlock"] = "x";
	elif (code == "movablez" || code == "moveablez"):
		aspects["movableBlock"] = "z";
	elif code == "beamup":
		aspects["beam"] = "up";
	elif code == "beamdown":
		aspects["beam"] = "down";
	elif code == "beamleft":
		aspects["beam"] = "left";
	elif code == "beamright":
		aspects["beam"] = "right";
	elif code == "off":
		aspects["on"] = false;
	elif code == "on":
		aspects["on"] = true;
	parseSimpleFunction("teleportto",code,aspects);
	parseSimpleFunction("teleportfrom",code,aspects);
	parseSimpleFunction("class",code,aspects);
	parseSimpleFunction("id",code,aspects);
	parseSimpleFunction("collisionon",code,aspects);
	parseSimpleFunction("collisionoff",code,aspects);
		
func realizeAspects(aspects={}):
	if aspects["substance"] == "water":
		makeGrassStoneWater(aspects);
	elif aspects["substance"] == "stone":
		makeGrassStoneWater(aspects);
	elif aspects["substance"] == "grass":
		makeGrassStoneWater(aspects);
	if aspects.has("door"):
		makeADoor(aspects);
	elif aspects.has("key"):
		makeAKey(aspects);
	elif aspects.has("movableBlock"):
		movableBlock(aspects);
	elif aspects.has("beam"):
		makeABeam(aspects);
	elif aspects.has("obelisk"):
		makeAnObelisk(aspects);
	elif aspects.has("teleportto"):
		makeATeleportTo(aspects);
	elif aspects.has("teleportfrom"):
		makeATeleportFrom(aspects);

func parseFunction(funcName,code):
	# if code begins with funcName and an open bracket...
	if code.substr(0,funcName.length()+1) == (funcName + "("):
		code = code.trim_prefix(funcName+"("); # ... remove one closing bracket...
		code = code.trim_suffix(")"); # ... and return the rest!
		return code;
	else:
		return null;
			
func parseSimpleFunction(funcName,code,aspects):
	var a = parseFunction(funcName,code);
	if a != null:
		print(funcName + "(" + a + ")");
		aspects[funcName] = a;

func realizeStuff(aspects,sb):
	realizeClass(aspects,sb);
	realizeId(aspects,sb);
	realizeCollisionOn(aspects,sb);
	realizeCollisionOff(aspects,sb);
	
func realizeClass(aspects,sb):
	var _class = aspects.get("class",null);
	if _class != null:
		sb.add_to_group(_class);
		
func realizeId(aspects,sb):
	var _id = aspects.get("id",null);
	if _id != null:
		sb.add_to_group("_id_" + _id);

func realizeCollisionOn(aspects,sb):
	var cOn = aspects.get("collisionon",null);
	if cOn != null:
		var g = "collisionon_" + cOn;
		print("adding to group " + g)
		sb.add_to_group(g);

func realizeCollisionOff(aspects,sb):
	var cOff = aspects.get("collisionoff",null);
	if cOff != null:
		var g = "collisionoff_" + cOff;
		print("adding to group " + g);
		sb.add_to_group(g);
	
func collisionOn(groupToTurnOn):
	print("collisionOn triggered! " + groupToTurnOn);
	get_tree().call_group(groupToTurnOn, "turnOn");
	$"../SoundBank".buttonpush();
	
func collisionOff(groupToTurnOff):
	print("collisionOff triggered! " + groupToTurnOff);
	get_tree().call_group(groupToTurnOff, "turnOff");
	$"../SoundBank".buttonpush();
