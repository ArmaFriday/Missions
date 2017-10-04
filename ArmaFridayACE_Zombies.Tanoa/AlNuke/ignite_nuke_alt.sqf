// by ALIAS
// BASIC

private ["_li2","_radius_c","_obj_nuke_c","_val","_schimb_c"];

if (!hasInterface) exitWith {};

_obj_nuke_c = _this select 0;
//_radius_c = _this select 1;

_inaltime_ciuperca= 450;
_inaltime_varf = 800;
enableCamShake true;
	_light_poz = "land_helipadempty_f" createVehiclelocal getPosATL _obj_nuke_c;
	
	// lumina
	_light_poz setPosATL [getPosATL _obj_nuke_c select 0,getPosATL _obj_nuke_c select 1,1600];

	[_light_poz,_obj_nuke_c] spawn 
	{
		_poz_lum = _this select 0;
		_poz_foot= _this select 1;
		_li2 = "#lightpoint" createVehicle getPosATL _poz_lum;
		_li2 lightAttachObject [_poz_lum, [0,0,0]];
		_li2 setLightAttenuation [/*start*/ 80, /*constant*/-1, /*linear*/ 10, /*quadratic*/ 10000, /*hardlimitstart*/3000,5000]; 
		_li2 setLightBrightness 20000;
		_li2 setLightDayLight true;
		_li2 setLightFlareSize 50;
		_li2 setLightFlareMaxDistance 10000;	
		_li2 setLightAmbient[1,0.7,0.1];
		_li2 setLightColor[1,0.7,0.1];

		_i=20000;	
		while {_i>0} do 
		{
			_li2 setLightBrightness _i;
			_i = _i-5;
			sleep 0.001;
		};
	};
	
	// orbire
	[] spawn 
	{		
		cutText ["", "WHITE OUT", 1];
		sleep 0.1;
		titleCut ["", "WHITE IN", 1];
		"dynamicBlur" ppEffectEnable true;   
		"dynamicBlur" ppEffectAdjust [40];   
		"dynamicBlur" ppEffectCommit 0;     
		"dynamicBlur" ppEffectAdjust [0.0];
		"dynamicBlur" ppEffectCommit 10;  
		sleep 10;
		"dynamicBlur" ppEffectEnable false; 
	};
	// distort
	[_obj_nuke_c] spawn 
	{
		_obj_sec_sound = _this select 0;
		alpha_c=1;
		while {alpha_c >0} do 
		{
			"colorCorrections" ppEffectEnable true;
			// edit line below if you want different color filter once the nuke is gone
			"colorCorrections" ppEffectAdjust[ 1, 1, alpha_c, [0.16, 0.38, 4.94, -1.65],[4.71, 2.68, 5, -0.29],[0.99, 0.81, -1.04, -1.76]];	
			"colorCorrections" ppEffectCommit 0;
			sleep 0.01;
			alpha_c=alpha_c-0.05;
		};
		//sleep 3;
		a4=-1.65;
		b4=-0.29;
		c4=-1.76;
		_schimb_c=false;

		_val = "#particlesource" createVehicleLocal getPos _obj_sec_sound;
		_val setParticleParams [["\A3\data_f\cl_basic", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 0],[0, 0, 0], 13, 1.5, 1, 0, [150,100,150], [[0.1, 0.1, 0.1, 0.5], [0.5, 0.5, 0.5, 0.5], [1, 1, 1, 0]], [1,0.5], 0.1, 1, "", "", _obj_sec_sound];
		_val setParticleRandom [0, [0, 0, 0], [5, 5, 0], 0, 0, [0, 0, 0, 0.1], 0, 0];
		_val setParticleCircle [50, [-80, -80, 0]];
		_val setDropInterval 0.001;		

		while {!_schimb_c} do 
		{
			a4=a4+0.0025;
			b4=b4+0.003;
			//hint str b4;
			c4=c4+0.0025;
			sleep 0.001;

			if (b4<0.86) then 
			{
			"colorCorrections" ppEffectAdjust[1, 1, 0, [0.16, 0.38, 4.94, a4],[4.71, 2.68, 5, b4],[0.99, 0.81, -1.04, c4]];
			"colorCorrections" ppEffectCommit 0;
			}
			else 
			{
				//playsound "nuke_3";
				addCamShake [10, 7, 27];
				playsound "impact_nuke_dist_1";
				cutText ["", "WHITE OUT", 1];
				sleep 0.1;
				titleCut ["", "WHITE IN", 1];
				"dynamicBlur" ppEffectEnable true;   
				"dynamicBlur" ppEffectAdjust [60];   
				"dynamicBlur" ppEffectCommit 0;     
				"dynamicBlur" ppEffectAdjust [0.0];  
				"dynamicBlur" ppEffectCommit 10;  
				"dynamicBlur" ppEffectEnable false;		
				"colorCorrections" ppEffectAdjust[1, 1, 0, [-0.2, 0.1, 0.23, -0.2],[0.76, -0.4, 0.86, 0.86],[-0.57, 0.81, -1.2, 0.88]];
				"colorCorrections" ppEffectCommit 0;
				_schimb_c=true;
				[] spawn {sleep 3; addCamShake [0.5, 150, 37];};
				sleep 15;
				deleteVehicle _val;
			};		
		};
	};
	
	[_obj_nuke_c,_inaltime_ciuperca] spawn 
	{
		_obj_moosh	= _this select 0;
		_inaltime_c = _this select 1;
		
		_ciuperca_poz = "land_helipadempty_f" createVehiclelocal getPosATL _obj_moosh;
		_ciuperca_poz setPosAsL [getPosAsL _obj_moosh select 0,getPosAsL _obj_moosh select 1,_inaltime_c];
		_poz_ini = getPosATL _ciuperca_poz;
		sleep 10.5;
		_palarie_acoperit = "#particlesource" createVehicle getPos _ciuperca_poz;
		_palarie_acoperit setParticleCircle [0, [0, 0, 0]];
		_palarie_acoperit setParticleRandom [0, [0.25, 0.25, 0], [0.175, 0.175, 0], 17, 0.25, [0, 0, 0, 0.1], 0, 0];
		_palarie_acoperit setDropInterval 0.007;
		
		_dir = 0;
		
		while {_dir<721} do 
		{
			_poz = [_poz_ini, 200, _dir] call BIS_fnc_relPos;
			_ciuperca_poz setPosATL [_poz select 0,_poz select 1,_inaltime_c];
			_ciuperca_poz setDir _dir;
			_palarie_acoperit setParticleParams [["\a3\Data_f\ParticleEffects\Universal\Universal", 16, 7, 48,1], "", "Billboard", 1, 50, [0, 0, 0], [0, 0, 140], 37, 9, 7.9, 0.1, [80, 200, 350,300], [[1, 0.8, 0.1, 1], [0, 0, 0, 1],[0.8, 0.5, 0.2, 0.1],[0, 0, 0, 0]], [0.08], 0, 0, "", "", _ciuperca_poz];
			//_palarie_acoperit setParticleParams [["\a3\Data_f\ParticleEffects\Universal\Universal", 16, 7, 48,1], "", "Billboard", 1, 50, [0, 0, 0], [0, 0, 110], 37, 9, 7.9, 0.1, [80, 250, 450,300], [[1, 0.8, 0.1, 1], [0, 0, 0, 1],[0.8, 0.5, 0.2, 0.1],[0, 0, 0, 0]], [0.08], 0, 0, "", "", _ciuperca_poz];
			_dir = _dir + 4;
			sleep 0.001;
		};
		deleteVehicle _ciuperca_poz;
		deleteVehicle _palarie_acoperit;
	};

// miez
	[_obj_nuke_c,_inaltime_varf] spawn 
	{
		_obj_tmp = _this select 0;
		_inalt_tgt = _this select 1;
		_palarie_varf = "land_helipadempty_f" createVehiclelocal getPosATL _obj_tmp;
		_palarie_varf setPosATL [getPosATL _obj_tmp select 0,getPosATL _obj_tmp select 1,0];
		
		_miez_hot = "#particlesource" createVehicleLocal getPos _obj_tmp;
		_miez_hot setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 27, [0, 0, 0], [0, 0, 60], 23, 0.9, 1, 0.01, [50/*150*/,450,350], [[1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 0]], [0.08], 1, 0, "", "", _palarie_varf];
		_miez_hot setParticleRandom [0,[0,0,0],[0,0,0],0,0,[0,0,0,0.1], 0,0];
		_miez_hot setParticleCircle [250, [0,0,0]];
		_miez_hot setDropInterval 0.005;		
		
		_fum_miez = "#particlesource" createVehicleLocal getPos _obj_tmp;
		_fum_miez setParticleParams [["\a3\Data_f\ParticleEffects\Universal\Universal", 16, 7, 48,1], "", "Billboard", 1, 52, [0, 0, 0], [0, 0, 60], 37, 0.9, 1, 0.01, [50/*250*/,350,200], [[1,0.8,0.1,1],[0.8,0.5,0.2,1],[0.8,0.5,0.2,0]], [0.08], 0, 0, "", "", _palarie_varf];
		_fum_miez setParticleRandom [1,[0,0,0],[0,0,0],13,0,[0,0,0,0.5], 0,0];
		_fum_miez setParticleCircle [300, [0,0,0]];
		_fum_miez setDropInterval 0.001;
		
		sleep .3;
		deleteVehicle _fum_miez;
		deleteVehicle _miez_hot;
		deleteVehicle _palarie_varf;
	};

// picior
_picior = "#particlesource" createVehicleLocal getPos _obj_nuke_c;
_picior setParticleCircle [50, [0, 0, 0]];
_picior setParticleRandom [0, [0.25, 0.25, 0], [0.175, 0.175, 0], 63, 0.1, [0, 0, 0, 0.1], 0, 0];
_picior setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 0], [0, 0, 50], 3, 9, 7.9, 0, [250, 200, 150, 100, 100, 100, 150], [[1, 1, 1, 0.5], [1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 0.5], [1, 1, 1, 1]], [0.08], 1, 0, "", "", _obj_nuke_c];
_picior setDropInterval 0.01;

// picior negru
_black_foot = "#particlesource" createVehicleLocal getPos _obj_nuke_c;
_black_foot setParticleParams [["\a3\Data_f\ParticleEffects\Universal\Universal", 16, 7, 48,1], "", "Billboard", 1, 10, [0, 0, 0],
		[0, 0, 130], 13, 1, 2, 0.01, [200,100,100,100,100], 
		[
		[0, 0, 0, 0.5],
		[0, 0, 0, 1], 
		[0.3, 0.3, 0.3, 1],
		[0, 0, 0, 0.5],
		[0, 0, 0, 0]
		],[0.25], 0.1, 1, "", "", _obj_nuke_c];
_black_foot setParticleRandom [2, [0, 0, 30], [0, 0, 0], 0, 0, [0, 0, 0, 0.1], 0, 0];
_black_foot setParticleCircle [100, [-5, -5, 0]];
_black_foot setDropInterval 0.02;

sleep 0.3;
_obj_nuke_c say3d ["nuke_2",5000];
[] spawn {sleep 0.3; addCamShake [10, 7, 27]};

/*
_effect_screen_gr = ppEffectCreate ["FilmGrain", 2000];  
_effect_screen_gr ppEffectEnable true; 
_effect_screen_gr ppEffectAdjust [1,5,2,3,3,true]; 
_effect_screen_gr ppEffectCommit 0;
*/	
[] spawn 
	{
		sleep 3;
		//_sunet_eko = "land_helipadempty_f" createVehiclelocal [getPosATL player select 0,getPosATL player select 1,(getPosATL player select 2) + 1];
		playsound "nuke_3";
		//_sunet_eko say3d ["nuke_3",5000];
		playsound "wind_strong";
		playsound "murmur";
		//sleep 8; deleteVehicle _sunet_eko;
	};

sleep 20;
_black_foot setDropInterval 0.01;
deleteVehicle _picior;
sleep 15;
deleteVehicle _black_foot;
_matrusca = true;
enableCamShake false;
deleteVehicle _light_poz;
/*
sleep 120;
ppEffectDestroy _effect_screen_gr;