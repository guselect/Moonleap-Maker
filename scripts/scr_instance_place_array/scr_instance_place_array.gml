/// @desc Same as `instance_place_list(...)` but it returns an array of collided instances.
function instance_place_array(x, y, obj, order_by_distance = false) {
  var _array = [];
  var _list = ds_list_create();
  
  instance_place_list(x, y, obj, _list, order_by_distance);
  for (var i = 0; i < ds_list_size(_list); i++) {
    _array[i] = ds_list_find_value(_list, i);
  }
  ds_list_destroy(_list);
  return _array;
}

function instance_place_array_wrap(x, y, obj, left, right, top, bottom) {
  var _array = [];
  var _col_wrap = instance_place_list_wrap(x, y, obj, left, right, top, bottom);
  
  __push_list_items_to_array(_col_wrap.lists.base, _array);
  __push_list_items_to_array(_col_wrap.lists.left, _array);
  __push_list_items_to_array(_col_wrap.lists.right, _array);
  __push_list_items_to_array(_col_wrap.lists.top, _array);
  __push_list_items_to_array(_col_wrap.lists.bottom, _array);
  
  _col_wrap.lists.destroy();
  
  return _array;
}

function instance_place_array_wrap_room(x, y, obj) {
  return instance_place_array_wrap(x, y, obj, room_width, room_width, room_height, room_height);
}

function __push_list_items_to_array(list, array) {
  for (var i = 0; i < ds_list_size(list); i++) {
    var _instances = ds_list_find_value(list, i);
    
    array_push(array, _instances);
  }
}
