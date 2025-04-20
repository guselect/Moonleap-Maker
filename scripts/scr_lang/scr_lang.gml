#macro LANG global.lang_strings[$ global.language]


function array_find_index_of_value(_array, _value)
{
    var _i = 0;
    repeat(array_length(_array))
    {
        if (_array[_i] == _value) return _i;
        ++_i;
    }
    
    return -1;
}

function is_in_array(_array, _value)
{
    var _i = 0;
    repeat(array_length(_array))
    {
        if (_array[_i] == _value) return true;
        ++_i;
    }
    
    return false;
}


function array_shuffle(array){
array_sort(array,function(){return choose(-1,1);});
}

///@desc Initialise language
function lang_init() {
	if (!variable_global_exists("lang_strings")) {
		global.lang_strings = {};
		global.language = "";
	}
}
lang_init(); 

/// @desc Add a new language
function lang_add(_name, _text) {
	lang_init(); //ensure language is initialised
	
	global.lang_strings[$ _name] = _text;
	
	show_debug_message("Language Added: "+_name);
	
	if (global.language == "") { lang_set(_name); }
}

/// @desc Set the current language
function lang_set(_name) {
	if (variable_struct_exists(global.lang_strings, _name)) {
		global.language = _name;	
		show_debug_message("Language set to: "+_name);
		
		with (oCamera) {
			if (global.language == "JA") or (global.language == "ZH") { 
				font = fntJA; }
			else { 
				font = fntSmall; 
			}
		}
	}
}

function lang_get() {
	return global.language;	
}

/// @desc Get text string in current language
function txt(_string_id) {
	var _lang_strings = global.lang_strings[$ global.language];
	
	//Check if this is a string array
	var _arr = string_pos("[",_string_id);
	var _index = 0;
	if (_arr) {
		_index = string_copy(_string_id,_arr+1,2);
		_index = string_digits(_index);
		if (_index != "") {	_index = max(0,real(_index)); }
		else { _index = 0; }
		_string_id = string_copy(_string_id,1,_arr-1);
	}
	
	var _text = variable_struct_get(_lang_strings, _string_id);
	
	if (is_undefined(_text)) {
		_text = "UNDEFINED";	
	}
	else if (is_array(_text)) {
		if (_index >= array_length(_text)) {
			_text = "UNDEFINED";	
		} else {
			_text = _text[_index];
		}
	}
	
	return _text;
}

