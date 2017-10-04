
if (!isServer) exitWith {};

_bomb_type			= _this select 0;
_custom_jdam_bomb	= _this select 1;
_plane_player		= _this select 2;
radius				= _this select 3;
damage_buildings_units = _this select 4;
weather_effect		= _this select 5;
radiation			= _this select 6;
fallout				= _this select 7;
//mushroom_type		= _this select 8;

if (typeOf _bomb_type != _custom_jdam_bomb) exitWith {};

	waitUntil {(getposATL _bomb_type select 2)<50};
	_poz_blow = getPos _bomb_type;
	deletevehicle _bomb_type;
	_bomb_obj_b = "Land_HelipadEmpty_F" createVehicle [_poz_blow select 0,_poz_blow select 1,0];
	
	[[_bomb_obj_b,radius],"AlNuke\ignite_nuke_alt.sqf"] remoteExec ["BIS_fnc_execVM"];
	
	if (fallout) then 
	{
		[[],"AlNuke\ash_nuke.sqf"] remoteExec ["BIS_fnc_execVM",0,true];
		null=[_bomb_obj_b] execvm "AlNuke\falling_nuke.sqf"
	};
	
	[] spawn 
	{
		if (weather_effect) then 
		{
			[[],"AlNuke\weather_nuke.sqf"] remoteExec ["BIS_fnc_execVM",0,true];
			null=[] execvm "AlNuke\fog_nuke.sqf"
		}
	};

	if (damage_buildings_units) then {sleep 55; nul = [_bomb_obj_b,radius] execvm "AlNuke\damage_nuke.sqf"};
	
	if (radiation) then 
	{
		[[_bomb_obj_b,radius],"AlNuke\ash_nuke.sqf"] remoteExec ["BIS_fnc_execVM",0,true];
	};
	
	sleep 120; deleteVehicle _bomb_obj_b;