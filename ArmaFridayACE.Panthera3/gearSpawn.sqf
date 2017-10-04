// PLAYER LOADOUT RESPAWN - by PWNER ACTUAL
 
// =======================================================================================
// INSTRUCTIONS INSTRUCTIONS    INSTRUCTIONS    INSTRUCTIONS    INSTRUCTIONS
// =======================================================================================
// SCRIPT: [] execVM "gearSpawn.sqf";
// =======================================================================================
// SCRIPT ORIGIN: "init.sqf"
// =======================================================================================
// SCRIPT INTENT: save player gear and load it when he respawns
// =======================================================================================
 
// =======================================================================================
// =======================================  SETUP  =======================================
// =======================================================================================
 
// =======================================================================================
// CLIENT &  HOST ONLY
// =======================================================================================
 
if (!hasInterface) exitWith {};
 
// =======================================================================================
// DECLARE VARIABLES
// =======================================================================================
 
private ["_player","_loadout"];
 
// =======================================================================================
// DEFINE VARIABLES
// =======================================================================================
 
_player     = _this select 0;
_player     = player;
 
// =======================================================================================
// ======================================  SCRIPT  =======================================
// =======================================================================================

if (name _player != "PrimaryZeus") then {
while   {true} do
{
while   {alive player}
do  {
    // save player loadout every 2 seconds
    _loadout = getUnitLoadout player;
    sleep 2;
    };
    // wait until player dies
    waitUntil   {!alive player};
    // wait for player to respawn
    waitUntil   {alive player};
    // god mode while loadout switches
    player allowdamage false;
    // black screen to hide the switch
    cutText ["","BLACK FADED",1];
    // allow some time for all changes to take place and mods to load
    sleep 5;
    // give player last saved loadout
    player setUnitLoadout _loadout;
    // fade from black
    cutText ["","BLACK IN",2];
    // allow damage again when player has weapons ready
    player allowdamage true;
};
};