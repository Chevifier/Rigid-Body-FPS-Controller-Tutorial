extends CSGBox

export(PackedScene) var projectile
export var fire_range = 100
export var projectile_speed = 100
export(NodePath) onready var target_path;
var target
onready var swivel = $swivel
onready var sp = $swivel/CSGCylinder/spawn_point
var attack = false
var offset = Vector3.UP
func _ready():
	if target_path == "":
		print("no target for cannon")
		return
	target = get_node(target_path)
	
func _physics_process(delta):
	if target==null:
		return
	if global_transform.origin.distance_to(target.global_transform.origin) <= fire_range:
		swivel.look_at(target.global_transform.origin+offset,Vector3.UP)
		attack = true
	else:
		attack = false


func _on_Timer_timeout():
	if attack == false:
		return
	var p : RigidBody = projectile.instance()
	get_tree().get_root().add_child(p)
	p.global_transform.origin = sp.global_transform.origin
	p.apply_central_impulse(-swivel.global_transform.basis.z*projectile_speed)
