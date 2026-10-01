/// @desc A stopwatch system constructor that performs time increasing when
/// counting is performed.
function FrameStopwatch() constructor {
	__time = 0;
	__increase_amount = 1;
	
	/// @desc This function is used to count the time.
	count = function() {
		__time += __increase_amount;
	}
	
	/// @desc This function is used to set the current time to zero.
	reset = function() {
		__time = 0;
	}
	
	/// @desc This function is used to get the current time.
	/// @returns {Real}
	get_time = function() {
		return __time;
	}
	
	/// @desc This function is used to get the increase amount value which is used
	/// to increase the time when the count is performed.
	/// @returns {Real}
	get_increase_amount = function() {
		return __increase_amount;
	}
	
	/// @desc This function is used to set the current time.
	/// @param {Real} time
	set_time = function(time) {
		if is_nan(time) then throw "Time must be a number.";
		
		__time = max(time, 0);
	}
	
	/// @desc This function is used to set the increase amount value which is used
	/// to increase the time when the count is performed.
	/// @param {Real} increase_amount
	set_increase_amount = function(increase_amount) {
		if is_nan(increase_amount) then throw "Decrease amount must be a number.";
		
		__increase_amount = abs(increase_amount);
	}
}

function DeltaStopwatch(): FrameStopwatch() constructor {
	__increase_amount = undefined;
	__time_speed = 1;
	
	/// @ignore
	get_decrease_amount = function() {
		throw "This function only works on FrameStopwatch struct.";
	}
	
	/// @ignore
	set_decrease_amount = function() {
		throw "This function only works on FrameStopwatch struct.";
	}
	
	/// @desc This function is used to count the time.
	count = function() {
		__time += ((delta_time / 1000000) * __time_speed);
	}
	
	/// @desc This function is used to get the time speed value which is used
	/// to increase the time when the count is performed.
	/// @returns {Real}
	get_time_speed = function() {
		return __time_speed;
	}
	
	/// @desc This function is used to set the time speed to control the count.
	/// @param {Real} time_speed The higher the value, faster is the time count.
	/// e.g.: 1 is the default speed. 2 is twice the speed. 0.5 is half of the default speed.
	set_time_speed = function(time_speed) {
		if is_nan(time_speed) then throw "Time speed must be a number.";
		
		__time_speed = abs(time_speed);
	}
}