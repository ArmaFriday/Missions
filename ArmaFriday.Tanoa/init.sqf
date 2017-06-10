[] execVM "QS_icons.sqf";
[] execVM "playerRanks.sqf";
[] execVM "gearSpawn.sqf";

setViewDistance 3000;

0 = [] spawn {
  while {true} do {
    {_unit = _x;
      if !(_unit getvariable ["edited",false]) then {
        { _x addCuratorEditableObjects [[_unit],true]} forEach AllCurators;
        _unit setvariable ["edited",true]};
    } foreach allUnits + vehicles;
  sleep 10;
  }
}