// ======================================================
// Change 'global.is_maker_mode' value to true to skip the intro and
// redirect to the level maker.
// ======================================================
global.is_maker_mode = true;


// ======================================================
// Custom Level Config.
// ======================================================

// Perfect score
#macro LEVEL_MAKER_MIN_PERFECT_SCORE 0
#macro LEVEL_MAKER_MAX_PERFECT_SCORE 99

// Level name length
#macro LEVEL_MAKER_LEVEL_NAME_LENGTH_MIN 6
#macro LEVEL_MAKER_LEVEL_NAME_LENGTH_MAX 32

// Level author name length
#macro LEVEL_MAKER_LEVEL_AUTHOR_LENGTH_MIN 3
#macro LEVEL_MAKER_LEVEL_AUTHOR_LENGTH_MAX 20

// Object tile cell size
#macro LEVEL_MAKER_GRID_OBJECTS_TILE_SIZE 8

// Tileset tile cell size
#macro LEVEL_MAKER_GRID_TILESETS_TILE_SIZE 16

enum LEVEL_MAKER_CURSOR { NOTHING, CURSOR, FINGER, ERASER, CANCEL }
enum LEVEL_MAKER_STYLE { GRASS, CLOUDS, FLOWERS, SPACE, DUNGEON, LENGTH }
enum LEVEL_MAKER_EDITOR_MODE { EDITING, TESTING, PLAYING }
