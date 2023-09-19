tool
extends TileMap

# Ints
export (int, 0, 9) var noise_octaves = 3
export (int) var noise_period        = 3
export (int) var map_width           = 80
export (int) var map_height          = 80
export (int) var level_seed          = 0

# Floats
export (float) var noise_persistence = 0.7
export (float) var noise_lacunarity  = 0.4
export (float) var noise_threshold   = 0.5

# Bools
export(bool)  var redraw_map  setget redraw

# Objects
var simplex_noise : OpenSimplexNoise = OpenSimplexNoise.new()

# Functions
func _ready() -> void:
	clear()
	generate()

func generate() -> void:
	simplex_noise.seed        = level_seed
	simplex_noise.octaves     = noise_octaves
	simplex_noise.period      = noise_period
	simplex_noise.persistence = noise_persistence
	simplex_noise.lacunarity  = noise_lacunarity
	
	for x in range(-map_width / 2.0, map_width / 2.0):
		for y in range(-map_height / 2.0, map_height / 2.0): 
			if simplex_noise.get_noise_2d(x, y) < noise_threshold: set_autotile(x, y)
	update_dirty_quadrants()

func set_autotile(x : int, y : int) -> void:
	set_cell(
		x,
		y,
		get_tileset().get_tiles_ids()[0],
		false,
		false,
		false,
		get_cell_autotile_coord(x, y)
	)
	update_bitmask_area(Vector2(x, y))

func redraw(_value = null):
	if !Engine.is_editor_hint(): return
	clear()
	generate()
