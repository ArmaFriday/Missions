params[ "_unit" ];
if (name _unit != "PrimaryZeus") then {
_unit removeAllEventHandlers 'HandleDamage';

// This code block ensures an incapacitated player can't be damaged.
_unit addEventHandler [ "HandleDamage", {
    private[ "_damage" ];
    params [ "_unit" ];
    
    //If we are not incapacitated
    if ( lifeState _unit != "INCAPACITATED" ) then {
        //Get revives handle damage
        _damage = _this call bis_fnc_reviveEhHandleDamage;
    } else {
        //if we are incapacitated
        _damage = 0;
    };

    _damage
    
}];
};