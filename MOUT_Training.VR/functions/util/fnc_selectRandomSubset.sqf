params ["_arr", "_count"];
// get a shallow copy of the array
_arr = [] + _arr;

_arrCount = count _arr;
_count = _arrCount min _count;

for [{_i = 0}, {_i < _count}, {_i = _i + 1}] do {
	private ["_temp"];
	_r = floor (random (_arrCount - _i - 1));
	_temp = _arr select _i;
	_arr set [_i, _arr select (_r + _i)];
	_arr set [(_r + _i), _temp];
};

_arr resize _count;	
_arr