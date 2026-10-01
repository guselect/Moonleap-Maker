enum MENU_CURSOR_TYPE { POINTER = 1, FINGER = 2 }

/// @desc This function creates the instance of a mouse object.
/// @param {String} layer_to_instantiate The layer where the object will be instantiated.
function object_mouse_create(layer_to_instantiate) {
  var mouse = instance_create_layer(0, 0, layer_to_instantiate, oMenuMouse)
  
  return mouse;
}