fnc_closeBasicDoors = {
	demo_basic_door_1 animate ["Door_1_rot", 0];
	demo_basic_door_2 animate ["Door_1_rot", 0];
	demo_basic_door_3 animate ["Door_1_rot", 0];
	demo_basic_door_4 animate ["Door_1_rot", 0];
};

fnc_closeAdvancedDoors = {
	demo_advanced_door_1 animate ["Door_1_rot", 0];
	demo_advanced_door_2 animate ["Door_1_rot", 0];
	demo_advanced_door_3 animate ["Door_1_rot", 0];
};

demo_basic_laptop addAction ["Close doors", {[] call fnc_closeBasicDoors}];
demo_advanced_laptop addAction ["Close doors", {[] call fnc_closeAdvancedDoors}];