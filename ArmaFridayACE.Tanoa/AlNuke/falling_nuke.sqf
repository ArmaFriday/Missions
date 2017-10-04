// by ALIAS
// nul = [obj_name_nuke] spawn compile preprocessFile "AlNuke\falling_nuke.sqf";

//if (!isServer) exitWith {};

	[] spawn {sleep 120; alias_fallout = false};
	
	_inte = 1;
	alias_fallout = true;
	_mark_temp = _this select 0;
	
	sleep 40;
	
while {alias_fallout} do 
{	
	[_mark_temp] spawn 
	{
		_mark_dif = _this select 0;
		_pozit = [getPos _mark_dif,random 500,random 360] call BIS_fnc_relPos;
		_objcar = createVehicle ["Land_Battery_F", _pozit, [], 0, "CAN_COLLIDE"];
		_objcar setPosATL [getPosATL _objcar select 0,getPosATL _objcar select 1, 700 + (random 500)];
	
		[[_objcar],"AlNuke\alias_schije.sqf"] remoteExec ["BIS_fnc_execVM"];
		[_objcar] spawn {_de_delete = _this select 0; sleep floor (5+random 6);	deleteVehicle _de_delete;};
	};
	
	sleep random _inte;
	_inte = _inte + 0.1;
};