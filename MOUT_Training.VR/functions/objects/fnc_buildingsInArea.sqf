params ["_areaMarker"];
	
private ["_a", "_b", "_maxRadius", "_buildings"];
_a = (markerSize _areaMarker) select 0;
_b = (markerSize _areaMarker) select 1;

_maxRadius = sqrt ((_a * _a) + (_b * _b));

_buildings = [];
{
	if(((position _x) inArea _areaMarker) && (count (_x buildingPos -1) > 2)) then {
		_buildings pushBack _x;
	};
} forEach nearestObjects [markerPos _areaMarker , ["house"], _maxRadius];
_buildings;