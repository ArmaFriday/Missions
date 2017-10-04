// by ALIAS
// see ini_nuke.sqf for more info about parameters

if (!isServer) exitWith {};

obj_nuke			= _this select 0;
radius				= _this select 1;
damage_buildings_units = _this select 2;
weather_effect 		= _this select 3;
radiation 			= _this select 4;
fallout 			= _this select 5;
//mushroom_type		= _this select 6;

	[[obj_nuke,radius],"AlNuke\ignite_nuke_alt.sqf"] remoteExec ["BIS_fnc_execVM"];
	
	if (fallout) then 
	{
		[[],"AlNuke\ash_nuke.sqf"] remoteExec ["BIS_fnc_execVM",0,true];
		null=[obj_nuke] execvm "AlNuke\falling_nuke.sqf"
	};
	
	[] spawn 
	{
		if (weather_effect) then 
		{
			[[],"AlNuke\weather_nuke.sqf"] remoteExec ["BIS_fnc_execVM",0,true];
			null=[] execvm "AlNuke\fog_nuke.sqf"
		}
	};

	if (damage_buildings_units) then {sleep 55; nul = [obj_nuke,radius] execvm "AlNuke\damage_nuke.sqf"};
	
	if (radiation) then 
	{
		[[obj_nuke,radius],"AlNuke\ash_nuke.sqf"] remoteExec ["BIS_fnc_execVM",0,true];
	};
	
	sleep 120; deleteVehicle obj_nuke;