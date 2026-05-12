extends Node2D

@export
var NumberOfAgents : int

var agent_scene = preload("res://agent.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(NumberOfAgents) :
		var agent = agent_scene.instantiate()
		add_child(agent)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
