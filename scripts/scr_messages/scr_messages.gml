/// @desc This function calls the message popup object to display a message on screen. It won't work if there is already a message popup active.
/// @param {String} _message The message to be displayed on screen.
/// @param {real|Undefined} _duration_frames A custom duration in frames to display the message. If not provided (that is, the value is `undefined`), the default duration defined in the object will be used. Default: `undefined`.
/// @param {String} _layer The layer the message popup object to be instantiated at. Default: `"Instances"`.
/// @param {bool} _show_on_draw_gui_end Whether the message popup will be drawn at the Draw GUI End. Default: `false`.
function call_message_popup(
  _message,
  _duration_frames = undefined,
  _layer = "Instances",
  _show_on_draw_gui_end = false
) {
  if instance_exists(oMessagePopup) {
    return;
  }
  var _message_popup = instance_create_layer(0, 0, _layer, oMessagePopup);
  
  _message_popup.message = _message;
  _message_popup.show_on_draw_gui_end = _show_on_draw_gui_end;
  if not is_undefined(_duration_frames) and is_real(_duration_frames) {
    _message_popup.duration_frames = _duration_frames;  
  }
}

/// @desc This function displays a full screen information with pagination if provided more than one text in `_messages` parameter.
/// @param {Array<String>} _messages An array of information to be displayed on screen.
/// @param {String} _layer The name of the layer where the message object will be instantiated. Default: `"Instances"`.
function call_message_info(_messages, _layer = "Instances") {
  if instance_exists(oMessageInfo) {
    return;
  }
  var _message_info = instance_create_layer(0, 0, _layer, oMessageInfo);
  
  _message_info.messages = _messages;
}