mout_town_laptop addAction ["Clear enemies", {[] remoteExec ["fnc_clearMoutTownEnemies", 2]}];
mout_town_laptop addAction ["Spawn enemies", {[] remoteExec ["fnc_spawnMoutTownEnemies", 2]}];

if (!isServer) exitWith {};

debug = false;

garrisonBuilding = {
	params ["_building", "_groupTemplate", "_side"];
	
	private ["_positions", "_group"];
	_positions = ([(_building buildingPos -1), count _groupTemplate] call fnc_selectRandomSubset);
	hint format ["%1 %2", count _positions, count _groupTemplate];
	_group = createGroup _side;
	
	diag_log "Next Group";
	
	{
		private ["_unit"];
		_unit = _group createUnit [(_groupTemplate select _forEachIndex), [0, 0, 0], [], 0, "NONE"];
		_unit setDir (random 360);
		_unit setPos _x;
		doStop _unit;
		_unit setVariable ["moutTownUnit", 1, false];
		
		{
			_x addCuratorEditableObjects [[_unit], true];
		} forEach allCurators;
	} forEach _positions;
};

garrisonArea = {
	params ["_marker", "_groupTemplates", "_side", "_count"];
	
	private ["_buildings", "_garrisonedBuildings"];
	_buildings = ([_marker] call fnc_buildingsInArea);
	
	if(debug) then {
		{
			private ["_name"];
			_name = format ["%1", _x];
			createMarker [_name, (position _x)];
			_name setMarkerType "mil_dot";
			_name setMarkerText format ["%1", count (_x buildingPos -1)];
		} forEach _buildings;
	};
	
	_garrisonedBuildings = [_buildings, _count] call fnc_selectRandomSubset;
	{
		private ["_groupTemplate"];
		_groupTemplate = (selectRandom _groupTemplates) select 0;
		[_x, _groupTemplate, _side] call garrisonBuilding;
		
		if(debug) then {
			(format ["%1", _x]) setMarkerColor "ColorRed";
		};
	} forEach _garrisonedBuildings;
};

groups = [
		[["rhs_vdv_rifleman", "rhs_vdv_grenadier"], 1],
		[["rhs_vdv_efreitor", "rhs_vdv_grenadier", "rhs_vdv_LAT"], 1],
		[["rhs_vdv_sergeant", "rhs_vdv_arifleman", "rhs_vdv_machinegunner_assistant"], 1]];

fnc_patrol = {
	params ["_group", "_marker"];

	while {true} do {
		waitUntil {(currentWaypoint _group) >= (count waypoints _group)};
		
		while {(count (waypoints _group)) > 0} do {
			deleteWaypoint ((waypoints _group) select 0);
		};
		
		private ["_nextPos", "_waypoint"];
		_nextPos = _marker call fnc_randomPointInArea;
		_waypoint = _group addWaypoint [_nextPos, 0];
		_waypoint setWaypointSpeed "LIMITED";
		_waypoint setWaypointCombatMode "RED";
		_waypoint setWaypointBehaviour "SAFE";
	};
};

fnc_spawnPatrol = {
	params["_groups", "_marker", "_side"];
	
	private _start = _marker call fnc_randomPointInArea;
	
	_group = createGroup _side;
	
	diag_log "Next Group";
	
	private _groupTemplate = (selectRandom _groups) select 0;
	{
		
		private ["_unit"];
		_unit = _group createUnit [_x, [0, 0, 0], [], 0, "NONE"];
		_unit setPos _start;
		_unit setVariable ["moutTownUnit", 1, false];
	} forEach _groupTemplate;
	
	_group setBehaviour "SAFE";
	
	{
		_x addCuratorEditableObjects [units _group, true];
	} forEach allCurators;
	
	[_group, _marker] call fnc_patrol;
};

fnc_spawnPatrols = {
	params["_marker", "_groups", "_side", "_count"];
	for "_i" from 1 to 10 do {
		[_groups, _marker, _side] spawn fnc_spawnPatrol;
	};
};



fnc_spawnMoutTownEnemies = {
	["mout_town_area", groups, east, 10] call garrisonArea;
	["mout_town_area", groups, east, 10] call fnc_spawnPatrols;
};

fnc_clearMoutTownEnemies = {
	{
		if (!isNil { _x getVariable "moutTownUnit" }) then {
			deleteVehicle _x;
		};
	} forEach allUnits;
};



