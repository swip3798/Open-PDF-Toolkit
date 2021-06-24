extends Control

export var page_number: int = 0
var cut_point: bool = false
var last: bool = false

onready var tex_rect: TextureRect = $VBoxContainer/TextureRect
onready var label: Label = $VBoxContainer/Label

signal cut_point_changed(page_number)

func _ready():
	$VBoxContainer/Label.text = str(page_number)

func load_texture(b64data: String):
	print("Before decoding ", page_number)
	var buffer := Marshalls.base64_to_raw(b64data)
	print("b64 decoded")
	print("page number ", page_number)
	var texture = ImageTexture.new();
	var image = Image.new();
	image.load_png_from_buffer(buffer);
	texture.create_from_image(image, 0);
	tex_rect.texture = texture
	label.text = tr("page") + " " + str(page_number + 1)
	
func make_last():
	last = true
	$Button.free()

func set_alpha(alpha):
	modulate.a = alpha

func _on_Button_pressed():
	cut_point = true
	emit_signal("cut_point_changed", page_number)


func _on_Button_focus_exited():
	cut_point = false
