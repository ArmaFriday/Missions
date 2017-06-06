// Custom Weapon Sway, Recoil and Stamina system

player setCustomAimCoef 0.5;
player addEventhandler ["Respawn", {player setCustomAimCoef 0.5}];
player addMPEventhandler ["MPRespawn", {player setCustomAimCoef 0.5}];

player setUnitRecoilCoefficient 0.8;
player addEventHandler ["Respawn", {player setUnitRecoilCoefficient 0.8}];
player addMPEventHandler ["MPRespawn", {player setUnitRecoilCoefficient 0.8}];

player enableStamina false; 
player addEventHandler ["Respawn", {player enablestamina false}];
player addMPEventhandler ["MPRespawn", {player enablestamina false}];

player disableConversation true;
player setSpeaker "NoVoice";