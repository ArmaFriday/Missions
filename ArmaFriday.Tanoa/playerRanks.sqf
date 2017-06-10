0 = [] spawn {
    waitUntil { !isNull player }; // Wait for player to initialize
    
    if (name player == "Whiplash") then {
        [player,"Jets_ID"] call bis_fnc_setUnitInsignia;
    }
    
}
