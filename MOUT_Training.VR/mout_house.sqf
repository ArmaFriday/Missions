mout_house_laptop addAction ["Clear enemies", {[] remoteExec ["fnc_clearMoutHouseEnemies", 2]}];
mout_house_laptop addAction ["Spawn enemies", {[] remoteExec ["fnc_spawnMoutHouseEnemies", 2]}];

if (!isServer) exitWith {};

private _group = mout_house_group;

// get the position and direction of each unit in the group
private _units = units _group;
moutHousePositions = _units apply { [getPosATL _x, getDir _x] };

// delete all of the units
{
	deleteVehicle _x;
} forEach _units;

fnc_spawnMoutHouseEnemies = {
	{
		private _group = createGroup east;

		private _pos = _x select 0;
		private _dir = _x select 1;
		private _unit = _group createUnit ["rhs_vdv_rifleman", _pos, [], 0, "NONE"];
		_unit setPos _pos;
		_unit setVariable ["moutHouseUnit", 1, false];
		_unit setDir _dir;
		_unit call fnc_watchDir;
		_unit setUnitPosWeak (selectRandom ["DOWN", "MIDDLE", "MIDDLE", "UP"]);
		_group setBehaviour "AWARE";
	} forEach ([moutHousePositions, 8] call fnc_selectRandomSubset);
};

fnc_clearMoutHouseEnemies = {
	{
		if (!isNil { _x getVariable "moutHouseUnit" }) then {
			deleteVehicle _x;
		};
	} forEach allUnits;
};