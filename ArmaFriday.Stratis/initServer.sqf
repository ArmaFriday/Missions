// This ensures a universal AI Skill setting by all Zeus placed assets
[] spawn {
    while {true} do {
        sleep 10;
       {
            _x setskill ["general",1];
            _x setskill ["aimingAccuracy",0.2];
            _x setskill ["aimingShake",0.4];
            _x setskill ["aimingSpeed",0.7];
            _x setskill ["reloadSpeed",0.8];
            _x setskill ["courage",0.6];
            _x setskill ["commanding",1];
            _x setskill ["spotDistance",0.2];
            _x setskill ["spotTime",0.9]
        } forEach allUnits;
    };
};