shoot_house_laptop addAction ["Reset easy", {[0.0] remoteExec ["fnc_resetShootHouse", 2]}];
shoot_house_laptop addAction ["Reset medium", {[0.5] remoteExec ["fnc_resetShootHouse", 2]}];
shoot_house_laptop addAction ["Reset hard", {[1.0] remoteExec ["fnc_resetShootHouse", 2]}];

if (!isServer) exitWith {};

rooms = [];

{
	private _door = _x select 0;
	private _group = _x select 1;
	
	// get the position and direction of each unit in the room's group
	private _units = units _group;
	private _positions = _units apply { [getPos _x, getDir _x] };
	
	// delete all of the units
	{
		deleteVehicle _x;
	} forEach _units;

	// close the door to the room
	//_door animate ["Door_1_rot", 0];
	
	// add the room data to the list of rooms
	rooms pushBack [_door, _positions];
} forEach [
		[shoot_house_door_01, shoot_house_group_01],
		[shoot_house_door_02, shoot_house_group_02],
		[shoot_house_door_03, shoot_house_group_03],
		[shoot_house_door_04, shoot_house_group_04],
		[shoot_house_door_05, shoot_house_group_05],
		[shoot_house_door_06, shoot_house_group_06],
		[shoot_house_door_07, shoot_house_group_07],
		[shoot_house_door_08, shoot_house_group_08],
		[shoot_house_door_09, shoot_house_group_09],
		[shoot_house_door_10, shoot_house_group_10]];

// close the last door
//shoot_house_door_11 animate ["Door_1_rot", 0];

resetFlag = false;

fnc_resetShootHouse = {
	params ["_scale"];
	
	{
		if (!isNil { _x getVariable "shootHouseUnit" }) then {
			deleteVehicle _x;
		};
	} forEach allUnits;

	{
		private _door = _x select 0;
		_door animate ["Door_1_rot", 0];
	} forEach rooms;
	shoot_house_door_11 animate ["Door_1_rot", 0];
	
	resetFlag = true;

	sleep 2;
	
	resetFlag = false;
	
	{
		private _door = _x select 0;
		private _positions = _x select 1;
		
		waitUntil {(_door animationPhase "Door_1_rot" > 0) || resetFlag};
		
		if (resetFlag) exitWith {};
		
		private _maxEnemies = 1;
		if ((count _positions) > 5) then {
			_maxEnemies = 2;
		};
		
		if ((count _positions) > 10) then {
			_maxEnemies = 3;
		};
		
		{
			private _group = createGroup east;

			private _pos = _x select 0;
			private _dir = _x select 1;
			private _unit = _group createUnit ["rhs_vdv_rifleman", _pos, [], 0, "CAN_COLLIDE"];
			_unit setDir _dir;
			_unit call fnc_watchDir;
			_unit setUnitPos (selectRandom ["DOWN", "MIDDLE", "MIDDLE", "UP"]);
			_group setBehaviour "AWARE";
			_unit setVariable ["shootHouseUnit", 1, false];
		} forEach ([_positions, floor ((random _maxEnemies) + _scale)] call fnc_selectRandomSubset);
	} forEach rooms;
};