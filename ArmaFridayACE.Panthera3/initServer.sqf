[] spawn {
    while {true} do {
        sleep 5;
        {
            if (!isPlayer _x && {!(_x getVariable ["hasSkillBeenSet",false])}) then {
                _x setskill ["general",0.7];
                _x setskill ["aimingAccuracy",0.5];
                _x setskill ["aimingShake",0.2];
                _x setskill ["aimingSpeed",0.7];
                _x setskill ["reloadSpeed",0.8];
                _x setskill ["courage",1];
                _x setskill ["commanding",1];
                _x setskill ["spotDistance",0.2];
                _x setskill ["spotTime",0.9];
                _x setVariable ["hasSkillBeenSet",true];
            };
        } forEach allUnits;
    };
};