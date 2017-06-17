#include "functions\all.sqf"

[] execVM "QS_icons.sqf";
[] execVM "playerRanks.sqf";
[] execVM "gearSpawn.sqf";

setViewDistance 3000;

_null = [] execVM "demo.sqf";
_null = [] execVM "shoot_house.sqf";
_null = [] execVM "mout_house.sqf";
_null = [] execVM "mout_town.sqf";