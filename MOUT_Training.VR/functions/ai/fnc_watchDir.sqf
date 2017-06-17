params ["_unit", "_dir"];

if (isNil "_dir") then {
	private _dir = getDir _unit;
	_unit doWatch ((position _unit) vectorAdd [50 * (sin _dir), 50 * (cos _dir), 1]);
} else {
	_unit doWatch ((position _unit) vectorAdd [50 * (sin _dir), 50 * (cos _dir), 1]);
};
