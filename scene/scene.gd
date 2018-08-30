extends Sprite

var area

var camera
var anchor

func input(viewport, event, shape_idx):
	if event is InputEventMouseButton and not event.pressed:
		printt("Before affecting zoom:", anchor.global_position, anchor.position)
		if event.button_index == 5:
			# zoom out
			camera.zoom *= 1.2
			# anchor.global_position *= 1.2
			$"../dialog_layer".transform.origin = get_viewport().canvas_transform.get_origin()
			printt("\tAfter zoom out:", anchor.global_position, anchor.position)
			printt("\tViewport canvas origin:", get_viewport().canvas_transform.get_origin())
			printt("\tdialog_layer canvas origin:", $"../dialog_layer".transform.origin)
			printt("-")
		elif event.button_index == 4:
			# zoom in
			camera.zoom *= 0.833
			# anchor.global_position *= 0.833
			$"../dialog_layer".transform.origin = get_viewport().canvas_transform.get_origin()
			printt("\tAfter zoom in:", anchor.global_position, anchor.position)
			printt("\tViewport canvas origin:", get_viewport().canvas_transform.get_origin())
			printt("\tdialog_layer canvas origin:", $"../dialog_layer".transform.origin)
			printt("-")

func _enter_tree():
	# Use size of background texture to calculate collision shape
	var size = get_texture().get_size()

	area = Area2D.new()
	var shape = RectangleShape2D.new()

	var sid = area.create_shape_owner(area)

	# Move origin of Area2D to center of Sprite
	var transform = area.shape_owner_get_transform(sid)
	transform.origin = size / 2
	area.shape_owner_set_transform(sid, transform)

		# Set extents of RectangleShape2D to cover entire Sprite
	shape.set_extents(size / 2)
	area.shape_owner_add_shape(sid, shape)

	add_child(area)

	camera = $"../camera"
	anchor = $"../dialog_layer/anchor_for_moving"  # Because Control doesn't have `global_position`

func _ready():
	area.connect("input_event", self, "input")

