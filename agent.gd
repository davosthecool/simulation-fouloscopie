extends CharacterBody2D


const SPEED : int = 100

var direction : Vector2
var time = 0.0
var amplitude = 50.0
var frequency = 5.0

func process_social_interactions(attraction_circle : Area2D, repulsion_cirlce : Area2D, alignment_circle : Area2D):
	if len(attraction_circle.get_overlapping_bodies()) > 0 :
		var neighbours = attraction_circle.get_overlapping_bodies()
		neighbours.sort_custom(func (a : Node2D,b : Node2D): 
			return position.distance_to(a.position) < position.distance_to(b.position)
		)
		var closest : Node2D = neighbours[0]
		
		var target_direction = (closest.global_position - global_position).normalized()
		direction = direction.lerp(target_direction, 0.05).normalized()
		


func _init() -> void:
	direction = Vector2(1,1).rotated(randf_range(0, TAU)).normalized()
	#direction = Vector2(-1,-0.7) * SPEED
	
	position.x = randf_range(200.0,1000.0)
	position.y = randf_range(100.0,500.0)
	
	
	
func _physics_process(delta: float) -> void:
	time += delta
	
	process_social_interactions($AttractionCircle, $RepulsionCircle, $AlignmentCircle)
	
	var forward = direction.normalized()
	var perpendicular = Vector2(-forward.y, forward.x)
	var wave = perpendicular * sin(time * frequency) * amplitude
	var final_direction = (forward + wave).normalized()
	velocity = final_direction * SPEED
	move_and_slide()
	
