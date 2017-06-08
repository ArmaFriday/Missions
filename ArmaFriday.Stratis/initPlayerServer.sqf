// This block ensures the Zeus has all players and mission assets loaded in
{
	if (!isnull (getassignedcuratorunit _x)) then {
		_unit = getassignedcuratorunit _x;
		if (isnull (getassignedcuratorlogic _unit)) then {
			unassignCurator _x;
			sleep 1;
			_unit assignCurator _x;
		};
	};
} foreach allcurators;