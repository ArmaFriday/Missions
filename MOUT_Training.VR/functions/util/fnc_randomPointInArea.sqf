params ["_marker"];

private ["_x", "_y", "_a", "_b", "_maxRadius", "_pos"];
_x = (markerPos _marker) select 0;
_y = (markerPos _marker) select 1;
_a = (markerSize _marker) select 0;
_b = (markerSize _marker) select 1;

_maxRadius = sqrt ((_a * _a) + (_b * _b));

if((_a == 0) || (_b == 0)) then {
	markerPos _marker;
} else {
	_pos = [0, 0, 0];
	while{!(_pos inArea _marker)} do {
		_pos = [_x + (random 2 * _maxRadius) - _maxRadius, _y + (random 2 * _maxRadius) - _maxRadius, 0];
	};
	_pos
};