// by ALIAS
// nul = [obj_nuke,radius] execvm "AlNuke\damage_nuke.sqf";

//if (!isServer) exitWith {};	
	
	sleep 80;
	_mark_x = _this select 0;
	_radius_x =  _this select 1;
	_npos = [getpos _mark_x select 0, getpos _mark_x select 1, 0];
	_obj_x = nearestObjects [_npos,["building","man","car","tank","plane","helicopter","TREE","SMALL TREE","BUSH"], _radius_x];
	{if (_x !=_mark_x) then {_x setDamage 1;};sleep 0.1} foreach _obj_x;