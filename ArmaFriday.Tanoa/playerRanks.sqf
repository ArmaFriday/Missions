0 = [] spawn {
    waitUntil { !isNull player }; // Wait for player to initialize

    // New Guy / Casual = chevronOne
    // Regular = chevronTwo
    // Specialist = chevronFour
    // NCO = chevronSix
    
    // Default rank (New Guy)
    [player,"chevronOne"] call bis_fnc_setUnitInsignia;

    ////////// Regular /////////////////////////////////////
    if (name player == "Foozlekiller") then {
        [player,"chevronTwo"] call bis_fnc_setUnitInsignia;
    };
    if (name player == "skifton") then {
        [player,"chevronTwo"] call bis_fnc_setUnitInsignia;
    };
    if (name player == "Frethen") then {
        [player,"chevronTwo"] call bis_fnc_setUnitInsignia;
    };
    if (name player == "Teo") then {
        [player,"chevronTwo"] call bis_fnc_setUnitInsignia;
    };
    if (name player == "Ironclaws") then {
        [player,"chevronTwo"] call bis_fnc_setUnitInsignia;
    };
    if (name player == "MRF") then {
        [player,"chevronTwo"] call bis_fnc_setUnitInsignia;
    };
    if (name player == "Stalker") then {
        [player,"chevronTwo"] call bis_fnc_setUnitInsignia;
    };
    if (name player == "Tantasqua") then {
        [player,"chevronTwo"] call bis_fnc_setUnitInsignia;
    };
    if (name player == "Kilthor") then {
        [player,"chevronTwo"] call bis_fnc_setUnitInsignia;
    };
    if (name player == "Saboathi") then {
        [player,"chevronTwo"] call bis_fnc_setUnitInsignia;
    };
    if (name player == "Reishi") then {
        [player,"chevronTwo"] call bis_fnc_setUnitInsignia;
    };

    ////////// NCO /////////////////////////////////////////
    if (name player == "Whiplash") then {
        [player,"chevronSix"] call bis_fnc_setUnitInsignia;
    };
    if (name player == "TypicalPhineas") then {
        [player,"chevronSix"] call bis_fnc_setUnitInsignia;
    };
    
};
