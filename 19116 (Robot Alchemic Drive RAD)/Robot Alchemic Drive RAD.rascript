// Robot Alchemic Drive: RAD
// #ID = 19116

/*
// $27E5E4: [32-bit] Pointer to doubly linked list of global variables.
//          +0x5c - Variables linked list (first element)
//          Stored in a 32-byte struct
//          +0x00=Pointer to previous element
//          +0x04=Pointer to next element
//          +0x08=Unclear, value between 0x01 and 0x11
//          +0x0c=Unclear, same as value in +0x08
//          +0x10=Pointer
//          ++0x0=Description of variable as a SJIS array (usually in Japanese)
//          +0x14=Pointer
//          ++0x0=Pointer
//          +++0x0=Pointer
//          ++++0x0=BAB::C_Buffer<char> (in ASCII)
//          +0x14=Pointer
//          ++0x0=Pointer
//          +++0x0=Pointer
//          ++++0x0=BAB::C_Buffer<char> (in ASCII)
//          +0x1c=Variable value
//          
//          ==1st layer==
//          ++0x04
//          
//          ==Main character number==
//          ++0x1c
//          0x0=Naoto
//          0x1=Ryo
//          0x2=Yui
//          
//          ==2nd layer==
//          +++0x04
//          
//          ==Initial robot==
//          +++0x1c
//          
//          ==3rd layer==
//          ++++0x04
//          
//          ==Control type==
//          ++++0x1c
//          0x0=Easy Mode
//          0x1= Normal Mode
//          
//          ==4th layer==
//          +++++0x04
//          
//          ==Ellen favor flag==
//          +++++0x1c
//          0x03>=Unlock Ellen ending (if Nanaho favor <=3)
//          0x02>=Unlock Sayou ending (if Nanaho favor <=3 and player=Yui)
//          
//          ==5th layer==
//          ++++++0x04
//          
//          ==Nanaho favor flag==
//          ++++++0x1c
//          0x04>=Unlock Nanaho ending
//          0x03<=Unlock Ellen ending (if Ellen favor >=3) or Sayou ending (if Ellen favor <=2 and player=Yui)
//          
//          +0x58 - Variables linked list (last element)
//          
//          ==98th layer==
//          ++0x00
//          
//          ==Language==
//          ++0x1c
//          0x00=Japanese
//          0x01=English
//          
//          ==97th layer==
//          +++0x00
//          
//          ==SYSTEM-boot_game_data_num==
//          +++0x1c
//          
//          ==96th layer==
//          ++++0x00
//          
//          ==Game mode==
//          ++++0x1c
//          0x1=Replaying mission through challenge mode
//          0x2=Training mission
//          0x0=Menu screen, story mode, etc
//          
//          ==95th layer==
//          +++++0x00
//          
//          ==SYSTEM-vs_map==
//          +++++0x1c
*/

// NOTABLE MEMORY ADDRESSES //

// Build array of doublely linked global variables. Variable data can be accessed by calling globalVar("var_name")
variables = ["main_character_number",
"initial_robot",
"control_type",
"ellen_favor_flag",
"nanao_favor_flag",
"nanao_economic_flag",
"keiko_flag",
"banhara_death_flag",
"misaki_heavy_industries_flag",
"nanao_amulet_flag",
"work",
"temporary_event",
"current_scenario",
"after_the_day_of_the_gods_destruction",
"number_of_continues",
"current_robot",
"map_type",
"amount_of_damage",
"collapse_senjo_city_hall",
"collapse_misaki_heavy_industries_headquarters_building",
"collapse_misaki_heavy_industries_senjo_factory",
"collapse_misaki_heavy_industries_research_institute",
"collapse_senjo_hospital",
"collapse_tsukioka_industries_headquarters",
"collapse_evacuation_guidance_team_headquarters",
"collapse_stadium",
"collapse_senjo_station",
"collapse_civilization_preservation_foundation",
"collapse_minami_senjo_station",
"collapse_supermarket",
"collapse_bakery",
"collapse_coffee_shop",
"collapse_observatory",
"collapse_bnn_senjo_branch",
"collapse_nanaho_s_house",
"collapse_kaoruko_s_apartment",
"collapse_nanaho_s_apartment",
"collapse_otawara_trading",
"collapse_ellen_s_apartment",
"collapse_banbara_s_apartment",
"collapse_tokyo_metropolitan_government_building",
"collapse_school",
"collapse_yaoya",
"building_collapse_point",
"frost_beam",
"hero_money",
"hero_shield",
"hero_booster",
"hero_drive",
"hero_grenade",
"vvl_armor_reinforcement",
"vvl_gigantic_booster",
"vvl_dual_knuckle",
"vvl_dive",
"vvl_wavel_missile",
"vvl_pyro_burner",
"vvl_gravity_zero",
"vvl_divine_upper",
"vvl_blast_hook",
"lio_armor_reinforcement",
"lio_gigantic_boomerang",
"lio_horobi",
"lio_sky_torpedo",
"lio_aerial_missile",
"lio_divine_laser",
"lio_gravity_zero",
"glg_armor_reinforcement",
"glg_machine_cannon",
"glg_all_shots_fired",
"glg_gaia_axe",
"glg_iron_tusk",
"glg_detonator",
"glg_shoulder_missile",
"glg_leg_missile",
"glg_gravity_zero",
"glg_machine_cannon_ammo_count",
"vvl_available_genesis_mode",
"vvl_available_genesis_cry",
"lio_available_reinforcement",
"glg_available_reinforcement",
"battle_map_number",
"match_1p_main_character_number",
"match_2p_main_character_number",
"match_1p_control_type",
"match_2p_control_type",
"match_1p_current_robot",
"match_2p_current_robot",
"mc_lastaccess",
"system_lastaccessdataindex",
"system_is_stereo",
"system_is_vibration",
"system_is_monitor_vibration",
"system_is_animated_gore",
"system_vs_robo",
"system_vs_map",
"game_mode",
"system_boot_game_data_num",
"language"]

head = dword(dword(0x27E5E4)+0x5c)
nodes = {}
curr = head
for variable in variables
{
  nodes[variable] = curr
  curr = dword(curr + 0x4) // or whatever offset for next
}

function globalVar(var_name){
    return dword(nodes[var_name]+0x1c)
}


// General Information
screenIndex0 = dword(0x27e9cc)
screenIndex1 = dword(0x248044)
screenIndex2 = dword(0x28e2b8)
screenIndex3 = dword(0x248040)
screenIndex4 = dword(0x28e2a0)
saveData = dword(dword(0x0027e5f4)+0x48)
dialogueIndexAddress = 0x2823c0
currentPilot = globalVar("main_character_number")
initialRobot = globalVar("initial_robot")
currentRobot = globalVar("current_robot")
currentScenario = globalVar("current_scenario")
gameMode = globalVar("game_mode")


// Character pointers
characterDataArray = dword(dword(0x0027e5e0)+0xc)
heroPointer = dword(characterDataArray+0x4)
robotPointer = dword(characterDataArray+0x8)
allyPointer = dword(characterDataArray+0xc) // Valdor in mission 24
enemyPointer = dword(characterDataArray+0x10)
enemy2Pointer = dword(characterDataArray+0x14)
enemy3Pointer = dword(characterDataArray+0x18)
enemy4Pointer = dword(characterDataArray+0x1c)
satellitePointer = dword(characterDataArray+0x20)


function inMission() => heroIsPresent()
function heroAppears() => characterDataArray!=0 && heroPointer!=0 && prev(heroPointer)==0
function heroIsPresent() => heroPointer!=0 && characterDataArray!=0
function robotIsPresent() => robotPointer!=0 && characterDataArray!=0
function allyIsPresent() => allyPointer!=0 && characterDataArray!=0
function enemyIsPresent() => enemyPointer!=0 && characterDataArray!=0
function enemy2IsPresent() => enemy2Pointer!=0 && characterDataArray!=0
function enemy3IsPresent() => enemy3Pointer!=0 && characterDataArray!=0
function enemy4IsPresent() => enemy4Pointer!=0 && characterDataArray!=0
function satelliteIsPresent() => satellitePointer!=0 && characterDataArray!=0
function enemyDestroyed() => enemy["health"]==0 && prev(enemy["health"])>0 && enemyPointer==prev(enemyPointer) && enemyIsPresent()
function enemy2Destroyed() => enemy2["health"]==0 && prev(enemy2["health"])>0 && enemy2Pointer==prev(enemy2Pointer) && enemy2IsPresent()
function enemy3Destroyed() => enemy3["health"]==0 && prev(enemy3["health"])>0 && enemy3Pointer==prev(enemy3Pointer) && enemy3IsPresent()
function enemy4Destroyed() => enemy4["health"]==0 && prev(enemy4["health"])>0 && enemy4Pointer==prev(enemy4Pointer) && enemy4IsPresent()
function satelliteDestroyed() => satellite["health"]==0 && prev(satellite["health"])>0 && satellitePointer==prev(satellitePointer) && satelliteIsPresent()


// Mission sub-indexes
function ep16PostMissionCutscene() => screenIndex0==0x8
function ep28PostMissionCutscene() => screenIndex0==0x6
function ep19A() => screenIndex0==0x21
function ep19B() => screenIndex0==0x1e

// City damage
cityDamage = dword(dword(0x0027e610)+0x6bc)
function misakiHqDestroyed() => globalVar("collapse_misaki_heavy_industries_headquarters_building")==1
function misakiFactoryDestroyed() =>  globalVar("collapse_misaki_heavy_industries_senjo_factory")==1
function senjoHospitalDestroyed() => globalVar("collapse_senjo_hospital")==1
function senjoCityHallDestroyed() => globalVar("collapse_senjo_city_hall")==1
function observatoryDestroyed() => globalVar("collapse_observatory")==1
function bnnSenjoBranchDestroyed() => globalVar("collapse_bnn_senjo_branch")==1
function schoolDestroyed() => globalVar("collapse_school")==1



// ADDRESS VALUES //
// Expected values for global var list
values = {
 "main_character_number": {
     0: "Naoto",
     1: "Ryo",
     2: "Yui"
 },
 "initial_robot": {
 //
     0: "Vavel",
     1: "Gllang",
     2: "Laguiole"
 },
 "control_type": {
     0: "Easy",
     1: "Normal"
 },
 "nanao_economic_flag": {
    // Starts at zero
    // Goes up every time Nanao's workplace is destoyed
    // Does down if competetor's workplaces are destroyed (Otawara in ep31, Otawara/Supermarket in ep32)
    // Can go negative    
 },
 "keiko_flag":{
    // Starts at zero
    // Goes up every time Keiko's apartment is destroyed
 },
 "banhara_death_flag": {
    // Set to true if Mika Banhara's helicopter is destroyed in ep51
    // If not set, epilogue mentions Mika Banhara going on to be a major media personality
 },
 "misaki_heavy_industries_flag": {
    // Once it hits (or exceeds) 0x9, Tomoe's post-misison report mentions that Misaki has broken off his engagement with Ellen, and triggers up to two post-mission events 
    // In first event the protag discusses the breakup with Ellen (only shown if the protag is Naoto or Ryo)
    // In the second event the protag discusses the breakup with Misaki
    // Epilogue will ALWAYS say "desperately trying to rebuild", even at 0
    8: "Ellen and Misaki ending",
    9: "Ellen-only ending"
 },
 "nanao_amulet_flag": { //Episode 9 only?
   0: "Pendant not found",
   1: "Pendant recovered"  
 },
 "current_scenario": {
  //Current episode
  //Stays at 1 on the main menu screen
  //Does not differentiate between 15a/15b, 18a/18b, 19a/19b missions, but can be inferred based on inital robot
  //During story mode, stays on previous episode during Intermission screen, updates to next episode after selecting "Next mission" 
  //During challenge mode, updates to selected episode once it has been selected from the list
    1: "Meganite Awakening",
    2: "Capital Crisis-1",
    3: "Capital Crisis-2",
    4: "Drill-1",
    5: "Drill-2",
    6: "Waterfront Showdown",
    7: "Phantom System",
    8: "Senjo's Protector",
    9: "Bay Area Defense",
    10: "Blast Furnace",
    11: "First Memory",
    12: "Evacuation Exercise",
    13: "E.G.G.",
    14: "Inferno",
    15: "The Mobile Fortress OR Airborne Dominator", // Airborne Dominator if map_type==7 (Tokyo), The Mobile Fortress otherwise
    16: "Ellen and Nanao",
    17: "A Family Rival",
    18: "Airborne Dominator OR The Complete - 1", // Airborne Dominator if map_type==7 (Tokyo), The Complete - 1 otherwise
    19: "Centurion OR The Complete - 2", // Hard to differentiate, using screenIndex0; Centurion if 0x21, The Complete - 2 otherwise
    20: "A Day at School",
    21: "Nanao's Water Soup",
    22: "Meganite Memories",
    23: "Bus stop",
    24: "The Dark One",
    25: "Ellen Bulnose",
    26: "Volgara Mystery",
    27: "Fortress",
    28: "Voices Unheard",
    29: "Close Combat",
    30: "Rat Race",
    31: "Defend & Destroy",
    32: "Yaoya Imperiled",
    33: "Mt. Chihaya Storming",
    34: "Second Memory",
    35: "The Black Meganite",
    36: "The Hero Alone",
    37: "Third Memory",
    38: "Genesis",
    39: "Dantarion",
    40: "Valhalla Dawning",
    41: "Four Warlords",
    42: "Spectral Visitation",
    43: "Bird's Eye News",
    44: "Live Action News",
    45: "Off the Air",
    46: "Chemical Warfare",
    47: "Windborne Darkness",
    48: "Lifesaver Express",
    49: "Higher Ground - 1",
    50: "Higher Ground - 2",
    51: "The Fall of Senjo",
    52: "Mt. Chichaya Showdown",
    53: "Meganite Future",
    201: "Training 2: Heavy Arms Training",
    300: "Training 1: Dantarion's Assault",
    700: "Versus Mode"
 },
 "after_the_day_of_the_gods_destruction":{
    // Activates at start of episode 41
    // Indicates whether starting Meganite's ultimate mode is available
    // For Vavel, indicates whether Genesis Cry is available?
    0: "Ultimate mode not available",
    1: "Ultimate available"
 },
 "number_of_continues":{
    // Tallies the number of times "Retry" has been selected for a mission
    // Starts at 0 when a mission is first attempted
    // Shows 1 during loading screens and cutscenes
 },
 "current_robot": {
    // 
     0: "Vavel",
     1: "Gllang",
     2: "Laguiole"
 },
 "work": {
    //Unclear; may reference last announced level of financial impact for MHI?
     0: "No announcements made",
     1: "bit0: MHI has rebuilt, lost 30b yen (vhh-49)",
     2: "bit1: MHI rebuilt, lost 500b yen",
     3: "bit2: Bulnose cancelled plans to partner with MHI"
 },
 "temporary_event": {
     //Bitfield that determines what post-mission events have been displayed
     "bit0": "Nanao commented on bakery's destruction", // 1st time bakery is destroyed between ep 10 and 30 (vev-1)
     "bit1": "Nanao mentioned getting a job at the cafe", // 2nd time bakery is destroyed between ep 10 and 30 (vev-2)
     "bit2": "Nanao mentioned getting a job as a dancer", // 3rd time bakery is destroyed between ep 10 and 30 (vev-6)
     "bit3": "Nanao met with Misaki", // 4th time bakery is destroyed between ep 10 and 30 (vev-8)
     "bit4": "Misaki donated 100b yen", // 5th time bakery is destroyed between ep 10 and 30 (vev-24)
     "bit6": "Date with Ellen", // Episode 42 if ellen_favor_flag>=3 (vev-47)
     "bit7": "Couldn't protect Misaki's company", //First time Misaki HQ is destroyed? (vev-66)
     "bit8": "Ellen discussed her broken engagement with Naoto/Ryo", // After Misaki finance >= 9 - Naoto/Ryo only (vev-71)
     "bit9": "Misaki discussed his broken engagement with protag", // After Misaki finance >= 9 - Naoto/Ryo must have already met with Ellen (vev-84)
     "bit10": "Misaki discussed MHI's destruction after the broken engagement", // After Misaki finance >= 10
     "bit11": "Misaki remains positive about MHI's destruction", // After Misaki finance >= 11
     "bit12": "Keiko found living in CFP HQ", //Keiko's apartment destroyed (vev-129)
     "bit13": "Keiko living in CPF HQ again", //Keiko's apartment destroyed 2nd time (vev-137)
     "bit14": "Keiko living in CFP HQ - don't try anything funny" //Keiko's apartment destroyed 3rd time (vev-154)
 },
 "map_type": {
    "title": {
        0: "No map loaded",
        1: "Senjo New City Center",
        2: "Downtown Senjo",
        3: "Senjo Port",
        4: "Mount Chihaya",
        5: "Volgara Territory",
        6: "Rome",
        7: "Toyko"
    },
    "senjo_peace_limit": {
        0: "No map loaded",
        1: 70,
        2: 70,
        3: 50,
        4: 60,
        7: 10,
    },
    "construction_minister_limit": {
        0: "No map loaded",
        1: 190,
        2: 140,
        3: 120,
        4: 120,
        7: 50
    }
 },
 "amount_of_damage":{
    //???
 },
 "building_collapse_point":{
    //Amount of damage done to the city, calculated after the mission ends
    //Affects Senjo Peace Award and Construction Minister Award
    //Affects how much damage Tomoe announces during the post-mission news report
    //0x00=000=Below one billion yen (senjou peace award)
    //0x46=070=Below one billion yen (senjou peace award)
    //0x47=071=Apprx two billion yen (construction minister)
    //0x6e=110=Apprx two billion yen (construction minister)
    //0x6f=111=Apprx five billion yen (construction minister)
    //0x8c=140=Apprx five billion yen (construction minister)
    //0x8d=141=Apprx five billion yen (no award)
    //0xa0=160=Apprx five billion yen (no award)
    //0xa1=161=Apprx ten billion yen (no award)
    //0xbe=190=Apprx ten billion yen
    //0xbf=191=At least ten billion yen
    //0xdc=220=At least ten billion yen
    //0xdd=221=Exceed twenty billion yen
    //0x12c=300=Exceed twenty billion yen
    //0x12d=301=Exceed thirty billion yen
    //0x1c2=450=Exceed thirty billion yen
    //0x1c3=451=Exceed fifty billion yen
    //0x2bc=700=Exceed fifty billion yen
    //0x2bd=701=Exceed one hundred billion yen
 },
 "frost_beam":{
   // Indicates whether ranged weapon has been replaced with frost beam
   // Only expected to be true in mission 14
   0: "Frost beam disabled",
   1: "Frost beam enabled"
 },
 "hero_money":{
    // Amount of money currently held in 100 billion yen
    // eg, 305 = 30,500,000,000 yen
},
"hero_shield":{
    // Upgrade affecting hero's max health
    0: "No shield",
    1: "Personal Shield",
    2: "Perfect Shield",
    3: "Nova Shield",
    "max":3
},
"hero_booster":{
    // Upgrade affecting hero's walk/run speed
    0: "No Booster",
    1: "Gravity Booster",
    2: "Perfect Booster",
    3: "Nova Booster",
    "max":3
},
"hero_drive":{
    // Upgrade affecting hero's walk/run speed
    0: "No Booster",
    1: "Gravity Drive",
    2: "Perfect Booster",
    3: "Nova Booster",
    "max":3
},
"hero_grenade":{
    // Upgrade affecting hero's grenade damage
    // Cannot use grenades at level 0
    0: "No Grenades",
    1: "Hand Grenade",
    2: "Power Grenade",
    3: "Nova Grenade",
    "max":3
},
"vvl_armor_reinforcement":{
    "max":5
},
"vvl_gigantic_booster":{
    "max":1
},
"vvl_dual_knuckle":{
    "max":1
},
"vvl_dive":{
    // Angelic Fall upgrade is only available after mission 40, and only if Vavel was the starting meganite
    1: "Meteor Dive",
    2: "Angelic fall",
    "max":2
},
"vvl_wavel_missile":{
    "max":5
},
"vvl_pyro_burner":{
    "max":5
},
"vvl_gravity_zero":{
    "max":1
},
"vvl_divine_upper":{
    "max":1
},
"vvl_blast_hook":{
    "max":1
},
"lio_armor_reinforcement":{
    "max":5
},
"lio_gigantic_boomerang":{
    "max":1
},
"lio_horobi":{
    // Annihilator upgrade
    // Only available after mission 40, and only if Laguiole was the starting meganite
    "max":1
},
"lio_sky_torpedo":{
    "max":5
},
"lio_aerial_missile":{
    "max":5
},
"lio_divine_laser":{
    0: "Nova Laser",
    1: "Divine Laser",
    "max":1
},
"lio_gravity_zero":{
    "max":1
},
"glg_armor_reinforcement":{
    "max":5
},
"glg_machine_cannon":{
    0: "30mm Rapid Cannon",
    1: "40mm Rapid Cannon",
    2: "50mm Rapid Cannon",
    "max": 2
},
"glg_all_shots_fired":{
    // Fire All Ordinance
    "max":1
},
"glg_gaia_axe":{
    // Gaia Axe
    "max":1
},
"glg_iron_tusk":{
    // Iron Tusk
    "max":1
},
"glg_detonator":{
    "max":5
},
"glg_shoulder_missile":{
    "max":5
},
"glg_leg_missile":{
    "max":5
},
"glg_gravity_zero":{
    // Gravity Zero
    "max":1
},
"glg_machine_cannon_ammo_count":{
    "max":5
},
"vvl_available_genesis_mode":{
    // Determines if square activates volcanic or genesis mode for Vavel
    // Activates at start of episode 38
    0: "Volcanic mode",
    1: "Genesis mode"
},
"vvl_available_genesis_cry":{
    // 
},
"lio_available_reinforcement":{
    // Demon Sword Desecrator?
},
"glg_available_reinforcement":{
    // Warhammer Sanctifier
    // Activates at start of episode 41
    0: "Sanctifier unavailable",
    1: "Sanctifier available" 
},
 "system_lastaccessdataindex": {
     0: "File01",
     1: "File02",
     2: "File03",
     3: "File04",
     4: "File05",
     5: "File06"
 },
 "game_mode": {
     0: "Story mode",
     1: "Challenge mode",
     2: "Training mode",
     3: "Versus mode"
 },
 "language": {
     0: "Japanese",
     1: "English"
 }
}

meganite_struct = {
    "z_position": {
        "offset": 0x14,
        "size": 32
    },
    "duration": { //How long character has been loaded [32-bit] (frames)
        // Increases once per frame
        // If using start to fast forward 
        "offset": 0x54,
        "size": 32
    },
    "x_position": {
        "offset": 0xa0,
        "size": 32
    },
    "y_position": {
        "offset": 0xa8,
        "size": 32
    },
    "max_health": { //Starting/max health [16-bit]
        "offset": 0xb4,
        "size": 16
    },
    "min_health": { //Minimum health [16-bit]
        // Applied in some missions when the enemy's health cannot drop below a certain level until conditions are met
        "offset": 0xb6,
        "size": 16
    },
    "health": { //Current health [16-bit]
        "offset": 0xb8,
        "size": 16
    },
    "is_invulnerable": { //Meganite vulnerability [16-bit]
        "offset": 0xba,
        "size": 16,
        "values":{
            0xcd00: "Vulnerable",
            0xcd01: "Invulnerable"
        }
    },
    "energy": { //Meganite max energy [16-bit]
        "offset": 0xbc,
        "size": 16
    },
    "max_energy": { //Meganite max energy [16-bit]
        "offset": 0xbe,
        "size": 16
    },
    "pilot_animation": {
        "offset": 0x458,
        "size": 32,
        "values": {
            0x00: "Standing",
            0x02: "Walking",
            0x04: "Running",
            0x06: "Jump 1",
            0x08: "Jump 2",
            0x0a: "Falling 2",
            0x0c: "Hit/thrown/lying down",
            0x0e: "Standing back up",
            0x1a: "Gravity drive",
            0x1c: "Crouching/riding meganite",
            0x20: "Holding something"
        }

    },
    "is_attacking": { //Meganite attacking status [32-bit]
        //Can be used in tandem with the the "Meganite last atack" to determine the current attack
        "offset": 0x9b8,
        "size": 32,
        "values": {
            0x00000000: "Not attacking",
            0xffffffff: "Attack animation active",
        }
    },
    "is_blocking": { //Blocking status [16-bit]
        //If blocking, less damage is taken and cannot be knocked down.
        // Not impacted by one-handed blocks
        "offset": 0x9a4,
        "size": 16,
        "values": {
            0x0000: "Not blocking",
            0x0001: "Blocking"
        }
    },
    "last_attack": { //Meganite last attack [32-bit]
        //Set when an attack or action is made, does not change until overwritten
        //Values that are not counted for "Use all attacks" achievements are commented out
        "offset": 0x9c8,
        "size": 32,
        "values": {
            "All": {
                0x0: "Jab",
                0x1: "Hook",
                0x2: "Uppercut",
                0x3: "Straight",
                0x4: "Chop",
                0x5: "Backhand",
                0xa: "Double punch",
                0xb: "Double hook",
                0xc: "Double straight",
                //0x14: "Grand Charge",
                //0x1e: "Crouch",
                //0x1f: "Stand",
                //0x20: "Jump",
                //0x2d: "Grab",            
            },
            "Vavel": {
                //0x65: "Deploy/retract Pyro Burner",
                //0x66: "Deploy/retract Drill Gear",
                0x68: "Harken Laser",
                0x69: "Lava Stream",
                0x6a: "Vavel Missile",
                0x6b: "Divine Upper",
                0x6c: "Pyro Burner",
                //0x70: "Genesis Cry", // Ultimate attack
                0x71: "Blast Hook",
                0x74: "Angelic Fall",
                0x75: "Gravity Zero",
                //0x1f5: "Activate Genesis Mode",
                0x258: "Dual Knuckle",
                0x259: "Assault Knuckle L",
                //0x25a: "Assault Knuckle R", // Don't need to count this AND Assault Knuckle L
            },
            "Laguiole": {
                0x6a: "Thunder hand",
                //0x65: "Deploy/retract Thunder Cannon",
                //0x66: "Deploy/retract Thunder Hand",
                0x67: "Nova/Divine Laser",
                0x68: "Aerial Corridor",
                0x69: "Gigantic Boomerang",
                //0x6c: "Annihilator", // Ultimate attack
                0x6f: "Gravity Zero"
            },
            "Gllang": {
                //0x65: "Deploy/retract Detonator",
                //0x66: "Deploy/retract Storm Hammer",
                0x67: "Shoulder Missile",
                0x68: "Leg Missile",
                0x69: "Gaia Axe",
                0x6a: "Gaia Buster",
                0x6c: "Proton Beam",
                0x6d: "30mm/40mm/50mm Cannon",
                0x6e: "Fire All Ordnance",
                0x6f: "Detonator",
                //0x70: "Iron Tusk",
                0x73: "Gravity Zero",
            }
        }
    },
    "falling_status":{
        "offset": 0xa70,
        "size": 32,
        "values": {
            0x00000000: "Falling/thrown",
            0x00000001: "Recovery animation 1",
            0x00000002: "Recovery animation 1",
            0x00000003: "Recovered (standing/walking/attacking/blocking/etc)",
            0xcdcdcdcd: "Never fallen"
        }
    }
}

time_leaderboard_id={
    1: 139294,
    3: 140761,
    5: 140763,
    6: 140956,
    7: 140958,
    8: 141087,
    9: 141089,
    10: 141715,
    11: 143104,
    13: 143106,
    14: 143108,
    "15a": 143110,
    "15b or 18a": 143141,
    16: 144125,
    17: 144127,
    "19a": 144129,
    "19b": 144223,
    20: 144620,
    21: 144622,
    22: 144770,
    23: 144772,
    24: 145077,
    25: 145977,
    26: 145979,
    27: 145998,
    28: 146000,
    29: 146025,
    30: 146027,
    31: 146389,
    32: 146391,
    33: 146393,
    38: 146395,
    39: 146738,
    40: 146740,
    41: 146921,
    42: 146923,
    43: 146948,
    44: 146994,
    45: 146996,
    46: 146998,
    47: 148102,
    48: 148123,
    49: 148177,
    50: 148179,
    51: 148189,
    52: 148191,
    53: 148192
}

score_leaderboard_id={
    1: 139295,
    3: 140762,
    5: 140764,
    6: 140957,
    7: 140959,
    8: 141088,
    9: 141090,
    10: 141716,
    11: 143105,
    13: 143107,
    14: 143109,
    "15a": 143111,
    "15b or 18a": 143142,
    16: 144126,
    17: 144128,
    "19a": 144130,
    "19b": 144224,
    20: 144621,
    21: 144623,
    22: 144771,
    23: 144773,
    24: 145078,
    25: 145978,
    26: 145980,
    27: 145999,
    28: 146001,
    29: 146026,
    30: 146028,
    31: 146390,
    32: 146392,
    33: 146394,
    38: 146396,
    39: 146739,
    40: 146741,
    41: 146922,
    42: 146924,
    43: 146949,
    44: 146995,
    45: 146997,
    46: 146999,
    47: 148103,
    48: 148124,
    49: 148178,
    51: 148190,
    53: 148193
}

highest_published_leaderboard_mission = 53

// Util Functions
function get_keys(dictionary){
    ret_array = []
    for key in dictionary{
        array_push(ret_array,key)
    }
    return ret_array
}

function array_merge(array1,array2){
    for val in array2{
        array_push(array1,val)
    }
    return array1
}


// Reusable data/functions
pilot = {}
for value in get_keys(meganite_struct)
{
    if(meganite_struct[value]["size"]==16)
        pilot[value] = word(heroPointer+meganite_struct[value]["offset"])
    else
        pilot[value] = dword(heroPointer+meganite_struct[value]["offset"])
}

robot = {}
for value in get_keys(meganite_struct)
{
    if(meganite_struct[value]["size"]==16)
        robot[value] = word(robotPointer+meganite_struct[value]["offset"])
    else
        robot[value] = dword(robotPointer+meganite_struct[value]["offset"])
}

enemy = {}
for value in get_keys(meganite_struct)
{
    if(meganite_struct[value]["size"]==16)
        enemy[value] = word(enemyPointer+meganite_struct[value]["offset"])
    else
        enemy[value] = dword(enemyPointer+meganite_struct[value]["offset"])
}

enemy2 = {}
for value in get_keys(meganite_struct)
{
    if(meganite_struct[value]["size"]==16)
        enemy2[value] = word(enemy2Pointer+meganite_struct[value]["offset"])
    else
        enemy2[value] = dword(enemy2Pointer+meganite_struct[value]["offset"])
}

enemy3 = {}
for value in get_keys(meganite_struct)
{
    if(meganite_struct[value]["size"]==16)
        enemy3[value] = word(enemy3Pointer+meganite_struct[value]["offset"])
    else
        enemy3[value] = dword(enemy3Pointer+meganite_struct[value]["offset"])
}


enemy4 = {}
for value in get_keys(meganite_struct)
{
    if(meganite_struct[value]["size"]==16)
        enemy4[value] = word(enemy4Pointer+meganite_struct[value]["offset"])
    else
        enemy4[value] = dword(enemy4Pointer+meganite_struct[value]["offset"])
}

satellite = {}
for value in get_keys(meganite_struct)
{
    if(meganite_struct[value]["size"]==16)
        satellite[value] = word(satellitePointer+meganite_struct[value]["offset"])
    else
        satellite[value] = dword(satellitePointer+meganite_struct[value]["offset"])
}

//missionDuration = dword(dword(0x0027e664)+0x54) //Resets during cutscene in ep1
missionDuration = dword(heroPointer+meganite_struct["duration"]["offset"])
hitCountMissionDuration = tally(0,
            pilot["duration"]-prev(pilot["duration"])>=1,
            pilot["duration"]-prev(pilot["duration"])>=2,
            pilot["duration"]-prev(pilot["duration"])>=3,
            pilot["duration"]-prev(pilot["duration"])>=4,
            pilot["duration"]-prev(pilot["duration"])>=5,
            pilot["duration"]-prev(pilot["duration"])>=6,
            pilot["duration"]-prev(pilot["duration"])>=7,
            pilot["duration"]-prev(pilot["duration"])>=8,
            pilot["duration"]-prev(pilot["duration"])>=9)

function robotLastAttackIs(attack){
    //Allow left or right Assault Knuckle
    if(attack==0x259)   return robot["last_attack"]>=0x259 && robot["last_attack"]<=0x25a
    return robot["last_attack"]==attack
}

function robotIsBlocking() => robot["is_blocking"]==0x1

function robotTakesDamage() => robot["health"]<prev(robot["health"])
                                //&& enemyIsPresent()
function enemyTakesDamage() => robot["is_attacking"]==0xffffffff && prev(enemy["health"])-enemy["health"]>10
                                //&& enemyIsPresent()
function enemy2TakesDamage() => robot["is_attacking"]==0xffffffff && prev(enemy2["health"])-enemy2["health"]>10
                                //&& enemy2IsPresent()
function enemy3TakesDamage() => robot["is_attacking"]==0xffffffff && prev(enemy3["health"])-enemy3["health"]>10
                                //&& enemy3IsPresent()
function enemy4TakesDamage() => robot["is_attacking"]==0xffffffff && prev(enemy4["health"])-enemy4["health"]>10
                                //&& enemy3IsPresent()


function robotIsFalling() => robot["falling_status"]==0
function enemyIsFalling() => enemy["falling_status"]==0
function enemy2IsFalling() => enemy2["falling_status"]==0
function enemy3IsFalling() => enemy3["falling_status"]==0
function enemy4IsFalling() => enemy4["falling_status"]==0

function enemyIsDown() => enemy["falling_status"]==0x1 || enemy["falling_status"]==0x2
function enemy2IsDown() => enemy2["falling_status"]==0x1 || enemy2["falling_status"]==0x2
function enemy3IsDown() => enemy3["falling_status"]==0x1 || enemy3["falling_status"]==0x2
function enemy4IsDown() => enemy4["falling_status"]==0x1 || enemy4["falling_status"]==0x2


//function missionStart() => screenIndex2==0x28e8d0
function missionStart() => heroAppears()
//TODO: Need to identify missionComplete screen index for undub patch
function missionComplete(mission_number) => screenIndex3==0x34282 && prev(screenIndex3)!=0x34282 && all_enemies_defeated(mission_number)
//function missionComplete() => screenIndex3==0x34282 && prev(screenIndex3)!=0x34282
//function missionComplete() => screenIndex1==0x12 && prev(screenIndex1)!=0x12
function missionFailed() => prev(screenIndex3==0x34282) && screenIndex3==0x34282
//function missionFailed() => neverscreenIndex3!=0x34282) && tally(10,screenIndex3==0x34282)
function returnToMainMenu() => screenIndex3==0x324be && prev(screenIndex3)!=0x324be
//function returnToMainMenu() => screenIndex1==0x31 //bad screen index; not unique, used during cutscene in ep1
function onTitleScreen() => screenIndex3==0x32453
//function returnToMainMenu() => screenIndex4==0x8d99
//function returnToChallengeSelection() => screenIndex1==0x136
function onLoadSavedGameMenu() => screenIndex3==0x3334d
function returnToChallengeSelection() => screenIndex3==0x33aa2 && prev(screenIndex3)!=0x33aa2
//function returnToChallengeSelection() => screenIndex4==0xa482
function missionIncomplete() => missionFailed() || screenIndex3==0x33aa2
//Determine if mission qualifies as a combat mission, or does not result in a battle or "Mission Clear" condition
function isCombatMission(){
    return currentScenario!=2
        && currentScenario!=4
        && currentScenario!=12
        && currentScenario!=34
        && currentScenario!=35
        && currentScenario!=36
        && currentScenario!=37
}

function get_enemy_count(mission_number){
    if(mission_number==52)  return 4
    if(mission_number==33)  return 3
    if(mission_number==20 || mission_number==24 || mission_number==48)    return 2
    return 1
}

function all_enemies_defeated(mission_number){
    if(get_enemy_count(mission_number)==4){
        return once(enemyDestroyed() && never(missionIncomplete()))
        && once(enemy2Destroyed() && never(missionIncomplete()))
        && once(enemy3Destroyed() && never(missionIncomplete()))
        && once(enemy4Destroyed() && never(missionIncomplete()))
    }
    
    if(get_enemy_count(mission_number)==3){
        return once(enemyDestroyed() && never(missionIncomplete()))
        && once(enemy2Destroyed() && never(missionIncomplete()))
        && once(enemy3Destroyed() && never(missionIncomplete()))
    }

    if(get_enemy_count(mission_number)==2){
        return once(enemyDestroyed() && never(missionIncomplete()))
        && once(enemy2Destroyed() && never(missionIncomplete()))
    }
    
    return once(enemyDestroyed() && never(missionIncomplete()))
}


// LEADERBOARD FUNCTIONS //
function timeLeaderboard(mission_number){
    leaderboard_id=0
    if(mission_number=="15a"){
        leaderboard_id=time_leaderboard_id[mission_number]
        start = ((currentScenario==15 && globalVar("map_type")!=7))
    }else if(mission_number=="15b or 18a"){
        leaderboard_id=time_leaderboard_id[mission_number]
        start = ((currentScenario==15 || currentScenario==18) && globalVar("map_type")==7)
    }else if(mission_number=="19a"){
        leaderboard_id=time_leaderboard_id[mission_number]
        start = (currentScenario==19 && ep19A())
    }else if(mission_number=="19b"){
        leaderboard_id=time_leaderboard_id[mission_number]
        start = (currentScenario==19 && ep19B())
    }else{
        if(mission_number<=highest_published_leaderboard_mission){
            leaderboard_id=time_leaderboard_id[mission_number]
        }
        start = currentScenario==mission_number
        if(mission_number==16) start = start && !ep16PostMissionCutscene()
        if(mission_number==28) start = start && !ep28PostMissionCutscene()
    }
    start = start && missionStart()
    leaderboard(
        "Episode "+mission_number,
        "Successfully complete episode "+mission_number+" as fast as possible",
        start,
        missionIncomplete(),
        missionComplete(mission_number),
        hitCountMissionDuration,
        format="FRAMES",
        lower_is_better=true,
        id=leaderboard_id)
}



function scoreLeaderboard(mission_number){
    leaderboard_id=0
    if(mission_number=="15a"){
        leaderboard_id=score_leaderboard_id[mission_number]
        start = ((currentScenario==15 && globalVar("map_type")!=7))
    }else if(mission_number=="15b or 18a"){
        leaderboard_id=score_leaderboard_id[mission_number]
        start = ((currentScenario==15 || currentScenario==18) && globalVar("map_type")==7)
    }else if(mission_number=="19a"){
        leaderboard_id=score_leaderboard_id[mission_number]
        start = (currentScenario==19 && ep19A())
    }else if(mission_number=="19b"){
        leaderboard_id=score_leaderboard_id[mission_number]
        start = (currentScenario==19 && ep19B())
    }else{
        if(mission_number<=highest_published_leaderboard_mission){
            leaderboard_id=score_leaderboard_id[mission_number]
        }
        start = currentScenario==mission_number
        if(mission_number==16) start = start && !ep16PostMissionCutscene()
        if(mission_number==28) start = start && !ep28PostMissionCutscene()
        
    }
    start = start && heroAppears()
    leaderboard(
        "Episode "+mission_number+" - Least City Damage",
        "Successfully complete episode "+mission_number+" with the least damage to the city",
        start,
        missionIncomplete(),
        missionComplete(mission_number),
        cityDamage,
        format="VALUE",
        lower_is_better=true,
        id=leaderboard_id
        )
}

// ACHIEVEMENT FUNCTIONS //

// Void achievements for pointers to global vars, used for debugging
function voidAch(varname)
{   
    achievement("[VOID] "+varname, "Pointer to "+varname, 0, globalVar(varname)==0x9999999)
}

// Upgrade Achievement Functions
function areFullyUpgraded(upgrade_name_array){  
    upgradeCheckArray = []
    for upgrade_name in upgrade_name_array{
        for upgradeLevel in range(1,values[upgrade_name]["max"]){
            array_push(upgradeCheckArray,once(globalVar(upgrade_name)>=upgradeLevel))
        }
    }  
    return upgradeCheckArray
}

function almostFullyUpgraded(upgrade_name_array){
    upgradeDeltaTotal = 0
    upgradeMaxTotal = 0
    //TODO: Need to run check against ored mem(upgrade) to delta(upgrade)
    for upgrade_name in upgrade_name_array{
        upgradeDeltaTotal = upgradeDeltaTotal + prev(globalVar(upgrade_name))
        upgradeMaxTotal = upgradeMaxTotal + values[upgrade_name]["max"]
    }
    return upgradeDeltaTotal == upgradeMaxTotal - 1
}

//TODO: Why can't this use addSource again??
function allUpgradesAchievement(upgradeType){
    allUpgradesAchievementDescription = "Purchase all "+upgradeType+" upgrades"
    if(upgradeType=="Vavel"){
        allUpgradesAchievementTitle = "The Vertical Fortress"
        upgradeList = ["vvl_armor_reinforcement",
                        "vvl_gigantic_booster",
                        "vvl_dual_knuckle",
                        "vvl_dive",
                        "vvl_wavel_missile",
                        "vvl_pyro_burner",
                        "vvl_gravity_zero",
                        "vvl_divine_upper",
                        "vvl_blast_hook"]
    }else if(upgradeType=="Gllang"){
        allUpgradesAchievementTitle = "The Castlekeep"
        upgradeList = ["glg_armor_reinforcement",
                        "glg_machine_cannon",
                        "glg_all_shots_fired",
                        "glg_gaia_axe",
                        //"glg_iron_tusk", // Gllang ultimate attack, can only be purchased if Gllang was starter
                        "glg_detonator",
                        "glg_shoulder_missile",
                        "glg_leg_missile",
                        "glg_gravity_zero",
                        "glg_machine_cannon_ammo_count"]
    }else if(upgradeType=="Laguiole"){
        allUpgradesAchievementTitle = "The Airborne Dominator"
        upgradeList = ["lio_armor_reinforcement",
                        "lio_gigantic_boomerang",
                        //"lio_horobi", // Laguiole ultimate attack, can only be purchased if Laguiole was starter
                        "lio_sky_torpedo",
                        "lio_aerial_missile",
                        "lio_divine_laser",
                        "lio_gravity_zero"]
    }else if(upgradeType=="Pilot"){
        allUpgradesAchievementTitle = "The Heir of Tsukioka"
        upgradeList = ["hero_shield",
                        "hero_booster",
                        "hero_drive",
                        "hero_grenade"]
    }

    upgradeArray = areFullyUpgraded(upgradeList)
    upgradeArrayDelta = almostFullyUpgraded(upgradeList)
    
    achievement(
        title = allUpgradesAchievementTitle,
        description = allUpgradesAchievementDescription,
        points = 10,
        trigger = almostFullyUpgraded(upgradeList)
                    && measured(
                        tally(length(upgradeArray),upgradeArray)
                    )
                    && never(onLoadSavedGameMenu()) //TODO: Need a better reset condition; values from last save are still shown on the main menu and load screens
    )
}


function allAwardsAchievement(achievementTitle,missionNumber,missionMapType){
    if(missionNumber=="15a"){
        allAwardsAchievementTrigger = once(missionStart() && currentScenario==15 && globalVar("map_type")==missionMapType)
    }else if(missionNumber=="15b or 18a"){
        allAwardsAchievementTrigger = once(missionStart() && (currentScenario==15 || currentScenario==18) && globalVar("map_type")==missionMapType)
    }else if(missionNumber=="19a or 19b"){
        allAwardsAchievementTrigger = once(missionStart() && currentScenario==19)
    }else{
        if(missionNumber==16){
            allAwardsAchievementTrigger = once(missionStart() && !ep16PostMissionCutscene() && currentScenario==missionNumber)
        }else if(missionNumber==28){
            allAwardsAchievementTrigger = once(missionStart() && !ep28PostMissionCutscene() && currentScenario==missionNumber)
        }else{
            allAwardsAchievementTrigger = once(missionStart() && currentScenario==missionNumber)
        }
    }
    allAwardsAchievementTrigger = allAwardsAchievementTrigger
                                    && never(returnToMainMenu() || returnToChallengeSelection())
                                    && never(cityDamage>values["map_type"]["senjo_peace_limit"][missionMapType])
                                    && trigger_when(missionComplete(missionNumber))
    if(values["map_type"]["title"][missionMapType]=="Senjo New City Center"){
        allAwardsAchievementTrigger = allAwardsAchievementTrigger && never(misakiHqDestroyed())
        allAwardsAchievementTrigger = allAwardsAchievementTrigger && never(misakiFactoryDestroyed())
        allAwardsAchievementTrigger = allAwardsAchievementTrigger && never(senjoHospitalDestroyed())
        allAwardsAchievementTrigger = allAwardsAchievementTrigger && never(senjoCityHallDestroyed())
    }else if(values["map_type"]["title"][missionMapType]=="Downtown Senjo"){
        allAwardsAchievementTrigger = allAwardsAchievementTrigger && never(schoolDestroyed())
    }else if(values["map_type"]["title"][missionMapType]=="Senjo Port"){
        allAwardsAchievementTrigger = allAwardsAchievementTrigger && never(observatoryDestroyed())
        allAwardsAchievementTrigger = allAwardsAchievementTrigger && never(bnnSenjoBranchDestroyed())
    }
    
    achievement(
        title = achievementTitle,
        description = "Complete episode "+missionNumber+" with all possible awards and under one million damage in Story or Challenge mode",
        points = 5,
        trigger = allAwardsAchievementTrigger
    )
}


// Mission Progression Achievement Functions
function missionProgressionAchievement(achievementTitle,missionRangeStart,missionRangeEnd,startingMeganite){
    missionProgressionAchievementDescription = "Complete episodes "+missionRangeStart+"-"+missionRangeEnd+" in story mode"
    if(startingMeganite==""){
        missionProgressionAchievementTrigger = once(missionStart() && currentScenario==missionRangeEnd && gameMode==0)
                                                && never(returnToMainMenu())
                                                && trigger_when(missionComplete(missionRangeEnd))
    }else{
        missionProgressionAchievementTrigger = once(missionStart() && currentScenario==missionRangeEnd && gameMode==0 && startingMeganite==initialRobot)
                                                && never(returnToMainMenu())
                                                && trigger_when(missionComplete(missionRangeEnd))
        if(values["initial_robot"][startingMeganite]=="Vavel") missionProgressionAchievementDescription=missionProgressionAchievementDescription+" as Vavel"
        if(values["initial_robot"][startingMeganite]=="Gllang") missionProgressionAchievementDescription=missionProgressionAchievementDescription+" as Gllang"
        if(values["initial_robot"][startingMeganite]=="Laguiole") missionProgressionAchievementDescription=missionProgressionAchievementDescription+" as Laguiole"
    }
    achievement(
        title = achievementTitle,
        description = missionProgressionAchievementDescription,
        points = 10,
        trigger = missionProgressionAchievementTrigger
    )
}


// Mission-specific Achievements
function senjoWouldHaveBeenGratefulAchievement(){
    gratefulSenjoAchievementTrigger = once(missionStart() && (currentScenario==15 || currentScenario==18) && globalVar("map_type")==7)
    gratefulSenjoAchievementTrigger = gratefulSenjoAchievementTrigger
                                    && never(returnToMainMenu() || returnToChallengeSelection())
                                    && never(cityDamage>values["map_type"]["construction_minister_limit"][1])
                                    && trigger_when(missionComplete("15b or 18a"))
    achievement(
        title = "Senjo Would Have Been Grateful",
        description = "Complete episode 15b or 18a with under five million damage in Story or Challenge mode",
        points = 5,
        trigger = gratefulSenjoAchievementTrigger
    )
}

function assistanceNotRequiredAchievement(){
// Once level 24 starts
// Reset if Valdor appears
// Trigger Volgara destruction
    achievement(
        title = "Assistance Not Required",
        description = "In episode 24, destroy a volgara before Valdor arrives",
        points = 5,
        trigger = once(missionStart() && currentScenario==24)
                    && never(missionIncomplete())
                    && never(allyIsPresent())
                    && trigger_when(enemyDestroyed() || enemy2Destroyed())
    )
}

function destroyedNoSatellitesAchievement(){
// Once level 42 starts
// Reset if first satellite is destroyed
// Trigger on mission complete
    achievement(
        title = "Bomberman",
        description = "Complete episode 42 without destroying any satellite machines ",
        points = 5,
        trigger = once(missionStart() && currentScenario==42)
                    && never(missionIncomplete())
                    && never(satelliteDestroyed())
                    && trigger_when(missionComplete(1))
    )
}


// Event Achievement Functions
function stringCompare(string,address){
    if(string=="vev\1-3"){
        stringArray = [0x76,0x65,0x76,0x5c,0x31,0x2d,0x33]
    }else if(string=="vev\4-1"){
        stringArray = [0x76,0x65,0x76,0x5c,0x34,0x2d,0x31]
    }else if(string=="vev\7-1"){
        stringArray = [0x76,0x65,0x76,0x5c,0x37,0x2d,0x31]
    }else if(string=="vev\20-4"){
        stringArray = [0x76,0x65,0x76,0x5c,0x32,0x30,0x2d,0x34]
    }else if(string=="vev\31-1"){
        stringArray = [0x76,0x65,0x76,0x5c,0x33,0x31,0x2d,0x31]
    }else if(string=="vev\68-2"){
        stringArray = [0x76,0x65,0x76,0x5C,0x36,0x38,0x2D,0x32]
    }else if(string=="vev\71a-1"){
        stringArray = [0x76,0x65,0x76,0x5C,0x37,0x31,0x61,0x2D,0x31]
    }else if(string=="vev\84-1"){
        stringArray = [0x76,0x65,0x76,0x5C,0x38,0x34,0x2D,0x31]
    }else if(string=="vev\113-1"){
        stringArray = [0x76,0x35,0x38,0x5C,0x31,0x31,0x33,0x2D,0x31]
    }else if(string=="vev\125-3"){
        stringArray = [0x76,0x35,0x38,0x5C,0x31,0x32,0x35,0x2D,0x33]
    }else if(string=="vev\132-1"){
        stringArray = [0x76,0x65,0x76,0x5c,0x31,0x33,0x32,0x2d,0x31]
    }else if(string=="vev\150-1"){
        stringArray = [0x76,0x65,0x76,0x5c,0x31,0x35,0x30,0x2d,0x31]
    }else if(string=="vev\157-1"){
        stringArray = [0x76,0x65,0x76,0x5C,0x31,0x35,0x37,0x2D,0x31]
    }else if(string=="v58\72a-4"){
        stringArray = [0x76,0x35,0x38,0x5C,0x37,0x32,0x61,0x2D,0x34]
    }else if(string=="v58\49a-4"){
        stringArray = [0x76,0x35,0x38,0x5C,0x34,0x39,0x61,0x2D,0x34]
    }else if(string=="v58\95-4"){
        stringArray = [0x76,0x35,0x38,0x5C,0x39,0x35,0x2D,0x34]
    }
    return all_of(range(0, length(stringArray) - 1), i => byte(address + i) == stringArray[i])
}

function postMissionEventAchievement(achievementTitle,achievementDescription,points,varName,minValue,voiceIndex){
    if(varName=="no_ellen_or_nanao_yui"){
        globalVarCheck = globalVar("nanao_favor_flag")<7 &&
                            globalVar("ellen_favor_flag")<2 &&
                            globalVar("main_character_number")==2
    }else{
        globalVarCheck = globalVar(varName)>=minValue    
    }
    dialogueCheck = stringCompare(voiceIndex,dialogueIndexAddress)
    achievement(
        title = achievementTitle,
        description = achievementDescription,
        points = points,
        trigger = globalVarCheck && dialogueCheck
    )
}


// Combat Achievement Functions
//TODO: May need to tweak to take into account ranged attacks, may not hit until after robot's no longer "attacking"
function attackLanded(attack_array,robot){  
    attackLandedArray = []
    for attack in attack_array{
            array_push(attackLandedArray,once(
                                            currentRobot==robot
                                            && robotLastAttackIs(attack)
                                            //&& enemyIsPresent()
                                            && enemyTakesDamage()
                                            ||
                                            currentRobot==robot
                                            && robotLastAttackIs(attack)
                                            //&& enemy2IsPresent()
                                            && enemy2TakesDamage()
                                            ||
                                            currentRobot==robot
                                            && robotLastAttackIs(attack)
                                            //&& enemy3IsPresent()
                                            && enemy3TakesDamage()
                                            ||
                                            currentRobot==robot
                                            && robotLastAttackIs(attack)
                                            //&& enemy4IsPresent()
                                            && enemy4TakesDamage()
                                            )
                                          )
    }  
    return attackLandedArray
}

function landAllAttacksAchievement(meganite){
    
    attackValueArray = get_keys(meganite_struct["last_attack"]["values"]["All"])
    
    if(meganite=="Vavel"){
        achievementTitle = "Rock Em Sock Em"
        achievementDescription = "Use all of Vavel's combat commands in a single session, not including starter-specific commands"
        attackValueArray = array_merge(attackValueArray,get_keys(meganite_struct["last_attack"]["values"]["Vavel"]))
        landAllAttacksArray = attackLanded(attackValueArray,0)
    }else if(meganite=="Laguiole"){
        achievementTitle = "Bird of Prey"
        achievementDescription = "Use all of Laguiole's combat commands in a single session, not including starter-specific commands"
        attackValueArray = array_merge(attackValueArray,get_keys(meganite_struct["last_attack"]["values"]["Laguiole"]))
        landAllAttacksArray = attackLanded(attackValueArray,2)
    }else if(meganite=="Gllang"){
        achievementTitle = "Suns Out Guns Out"
        achievementDescription = "Use all of Gllang's combat commands in a single session, not including starter-specific commands"
        attackValueArray = array_merge(attackValueArray,get_keys(meganite_struct["last_attack"]["values"]["Gllang"]))
        landAllAttacksArray = attackLanded(attackValueArray,1)
    }
    achievement(
        title = achievementTitle,
        description = achievementDescription,
        points = 10,
        trigger = measured(
                    tally(length(landAllAttacksArray),landAllAttacksArray)
                  )
    )
}

function blockAllAttacksAchievement(){
// Once level starts
// And once robot has blocked at least one attack
// Reset if damage is taken
// Trigger on mission complete
                            
    achievement(
        title = "Keep Those Hands Up",
        description = "Block at least three attacks and take no unblocked damage during an episode",
        points = 5,
        trigger = once(missionStart())
                    && measured(repeated(3,(robotIsPresent() && robotTakesDamage() && robotIsBlocking())))
                    && never(missionIncomplete())
                    && never(robotIsPresent() && robotTakesDamage() && !robotIsBlocking()) //TODO: Need to debug; measure will count during a mission after robot took damage
                    && (
                        (currentScenario==52 && trigger_when(missionComplete(52)))
                        || (currentScenario==33 && trigger_when(missionComplete(33)))
                        || (currentScenario==20 && trigger_when(missionComplete(20)))
                        || (currentScenario==24 && trigger_when(missionComplete(24)))
                        || (currentScenario==48 && trigger_when(missionComplete(48)))
                        || (currentScenario!=20
                            && currentScenario!=24
                            && currentScenario!=33
                            && currentScenario!=48
                            && currentScenario!=52
                            && trigger_when(missionComplete(1)))
                       )
    )
}

function useNormalControlsAchievement(){
    achievement(
        title = "Through This Controller, I Can Feel Every Beat of Its Heart",
        description = "Defeat all enemies in an episode using normal controls",
        points = 5,
        trigger = once(missionStart() && globalVar("control_type")==1 && isCombatMission())
                    && never(missionIncomplete())
                    && (
                        (currentScenario==52 && trigger_when(missionComplete(52)))
                        || (currentScenario==33 && trigger_when(missionComplete(33)))
                        || (currentScenario==20 && trigger_when(missionComplete(20)))
                        || (currentScenario==24 && trigger_when(missionComplete(24)))
                        || (currentScenario==48 && trigger_when(missionComplete(48)))
                        || (currentScenario!=20
                            && currentScenario!=24
                            && currentScenario!=33
                            && currentScenario!=48
                            && currentScenario!=52
                            && trigger_when(missionComplete(1)))
                       )
    )
}
/*
function oneHitKOAchievement(){
    achievement(
        title = "One Punch Man",
        description = "Defeat an enemy with full health in one hit",
        points = 5,
        trigger = inMission() &&
                    (
                        (enemyIsPresent() && enemy["health"] == 0 && prev(enemy["health"]) == enemy["max_health"])
                        || (enemy2IsPresent() && enemy2["health"] == 0 && prev(enemy2["health"]) == enemy2["max_health"])
                        || (enemy3IsPresent() && enemy3["health"] == 0 && prev(enemy3["health"]) == enemy3["max_health"])
                        || (enemy4IsPresent() && enemy3["health"] == 0 && prev(enemy4["health"]) == enemy4["max_health"])
                    )
    )
}
*/

function attackDownedEnemyAchievement(){
    achievement(
        title = "Hit 'Em While They're Down",
        description = "Hit a downed enemy three times before they get back up",
        points = 5,
        trigger = inMission() &&
                    (
                        (tally(3,enemyIsPresent() && enemyTakesDamage() && enemyIsDown()) && never(enemyIsPresent() && !enemyIsDown()))
                        || (tally(3,enemy2IsPresent() && enemy2TakesDamage() && enemy2IsDown()) && never(enemy2IsPresent() && !enemy2IsDown()))
                        || (tally(3,enemy3IsPresent() && enemy3TakesDamage() && enemy3IsDown()) && never(enemy3IsPresent() && !enemy3IsDown()))
                        || (tally(3,enemy4IsPresent() && enemy4TakesDamage() && enemy4IsDown()) && never(enemy4IsPresent() && !enemy4IsDown()))
                    )
    )
}

function launchAndHitEnemyAchievement(){
    //Use gravity zero on an enemy, then hit them again on the way down
    //Gravity Zero attack value is different for each Meganite, restricting to Vavel to limit comparisons
    achievement(
        title = "Keep Your Eye on the Ball",
        description = "As Vavel, launch an enemy with Gravity Zero then hit them again before they hit the ground",
        points = 5,
        trigger = inMission() &&
                    (
                        (once(robot["last_attack"]==0x75 && enemyTakesDamage()) && robot["last_attack"]!=0x75 && enemyTakesDamage()
                            && never(!enemyIsFalling()))
                        || (once(robot["last_attack"]==0x75 && enemy2TakesDamage()) && robot["last_attack"]!=0x75 && enemy2TakesDamage()
                            && never(!enemy2IsFalling()))
                        || (once(robot["last_attack"]==0x75 && enemy3TakesDamage()) && robot["last_attack"]!=0x75 && enemy3TakesDamage()
                            && never(!enemy3IsFalling()))
                        || (once(robot["last_attack"]==0x75 && enemy4TakesDamage()) && robot["last_attack"]!=0x75 && enemy4TakesDamage()
                            && never(!enemy4IsFalling()))
                    )
    )
}

function attackFallingEnemyAchievement(){
    achievement(
        title = "Then You Have My Permission to Fall",
        description = "Hit a falling enemy three times before they hit the ground",
        points = 5,
        trigger = inMission() &&
                    (
                        (tally(3,enemyTakesDamage() && enemyIsFalling() && currentRobot==2)
                            && never(!enemyIsFalling()))
                        || (tally(3,enemy2TakesDamage() && enemy2IsFalling() && currentRobot==2)
                            && never(!enemy2IsFalling()))
                        || (tally(3,enemy3TakesDamage() && enemy3IsFalling() && currentRobot==2)
                            && never(!enemy3IsFalling()))
                        || (tally(3,enemy4TakesDamage() && enemy4IsFalling() && currentRobot==2)
                            && never(!enemy4IsFalling()))
                    )
    )
}

//TODO: Debug why "trigger when" isn't working
function singleAttackAchievement(achTitle,upgrade_name,robotIndex,attackIndex){
    robotName = values["current_robot"][robotIndex]
    if(attackIndex==0x70){
        if(robotIndex==0) attackName = "Genesis Cry"
        if(robotIndex==1) attackName = "Iron Tusk"
    }
    if(attackIndex==0x6c) attackName = "Annihilator"
    if(attackIndex==0x6e) attackName = "Fire All Ordnance"
     
    achievement(
        title = achTitle,
        description = "As "+robotName+", kill a Volgara with over 1000 health using only '"+attackName+"'",
        points = 5,
        trigger = inMission()
                    && currentRobot==robotIndex
                    && never(robot["last_attack"]!=attackIndex)
                    && (
                        (once(enemy["health"]>1000 && robot["last_attack"]==attackIndex && prev(robot["last_attack"])==attackIndex)
                            && trigger_when(enemy["health"]==0)
                        )
                        || (once(enemy2["health"]>1000 && robot["last_attack"]==attackIndex && prev(robot["last_attack"])==attackIndex)
                            && trigger_when(enemy2["health"]==0)
                        )
                        || (once(enemy3["health"]>1000 && robot["last_attack"]==attackIndex && prev(robot["last_attack"])==attackIndex)
                            && trigger_when(enemy3["health"]==0)
                        )
                        || (once(enemy4["health"]>1000 && robot["last_attack"]==attackIndex && prev(robot["last_attack"])==attackIndex)
                            && trigger_when(enemy4["health"]==0)
                        )
                        || //If player has the capability to earn this achievment, show an indicator
                        enemyIsPresent() && enemy["health"]>1000 && globalVar(upgrade_name)==1 && trigger_when(enemy["health"]<1000)
                            ||
                        enemy2IsPresent() && enemy2["health"]>1000 && globalVar(upgrade_name)==1 && trigger_when(enemy2["health"]<1000)
                            ||
                        enemy3IsPresent() && enemy3["health"]>1000 && globalVar(upgrade_name)==1 && trigger_when(enemy3["health"]<1000)
                            ||
                        enemy4IsPresent() && enemy4["health"]>1000 && globalVar(upgrade_name)==1 && trigger_when(enemy4["health"]<1000)
                    )

    )
}


// LEADERBOARDS //
for mission_number in [1,3,5,6,7,8,9,10,11,13,14,"15a","15b or 18a",16,17,"19a","19b"]{
    timeLeaderboard(mission_number)
    scoreLeaderboard(mission_number)
}

for mission_number in range(20,33){
    timeLeaderboard(mission_number)
    scoreLeaderboard(mission_number)
}

for mission_number in range(38,49){
    timeLeaderboard(mission_number)
    scoreLeaderboard(mission_number)
}


timeLeaderboard(50)
timeLeaderboard(51)
scoreLeaderboard(51)
timeLeaderboard(52)
timeLeaderboard(53)
scoreLeaderboard(53)


// ACHIEVEMENTS //
achievement("[VOID] Pilot data", "Pointer to pilot health", 0, pilot["health"]==0x9999)
achievement("[VOID] Meganite data", "Pointer to meganite health", 0, robot["health"]==0x9999)
achievement("[VOID] Enemy data", "Pointer to enemy health", 0, enemy["health"]==0x9999
                                                                && enemy2["health"]==0x9999
                                                                && enemy3["health"]==0x9999
                                                                && enemy4["health"]==0x9999)
achievement("[VOID] City damage", "Pointer to city damage", 0, cityDamage==0x9999)
achievement("[VOID] Save Data","Pointer to save data", 0, dword(saveData+0xb8)==0x9999)
//achievement("[VOID] Mission timer","Pointer to mission timer", 0, missionDuration==9999)
//voidAch("temporary_event")
voidAch("collapse_ellen_s_apartment")
//voidAch("building_collapse_point")
achievement("[VOID] Ellen favor +1", "Ellen favor increase by 1", 0, globalVar("ellen_favor_flag")==prev(globalVar("ellen_favor_flag"))+1)
achievement("[VOID] Ellen favor +2", "Ellen favor increase by 2", 0, globalVar("ellen_favor_flag")==prev(globalVar("ellen_favor_flag"))+2)
achievement("[VOID] Ellen favor +3", "Ellen favor increase by 2", 0, globalVar("ellen_favor_flag")==prev(globalVar("ellen_favor_flag"))+3)
achievement("[VOID] Nanao favor +1", "Nanao favor increase by 1", 0, globalVar("nanao_favor_flag")==prev(globalVar("nanao_favor_flag"))+1)
achievement("[VOID] Nanao favor +2", "Nanao favor increase by 2", 0, globalVar("nanao_favor_flag")==prev(globalVar("nanao_favor_flag"))+2)
achievement("[VOID] Nanao favor +3", "Nanao favor increase by 2", 0, globalVar("nanao_favor_flag")==prev(globalVar("nanao_favor_flag"))+3)


missionProgressionAchievement("Driller vs Driller",1,5,0)
missionProgressionAchievement("The World Doesn't Run on Theory Alone",6,8,0)
missionProgressionAchievement("A Storm Will Arrive",9,11,0)
missionProgressionAchievement("Everyone Should Be Asking \"Where's Laguiole?\"",12,15,0)
missionProgressionAchievement("From Tower to Trio",16,19,0)

missionProgressionAchievement("Tread Lightly and Carry a Big Hammer",1,5,1)
missionProgressionAchievement("Nothing Says \"Tank You\" Like Money",6,8,1)
missionProgressionAchievement("Tanks For the Memories",9,11,1)
missionProgressionAchievement("The G and U are slient",12,15,1)
missionProgressionAchievement("From Tank to Trio",16,19,1)

missionProgressionAchievement("Welcome to the Thunderdome",1,5,2)
missionProgressionAchievement("More Like Flight AND Fight Response",6,8,2)
missionProgressionAchievement("The Ancient Legend Was True",9,11,2)
missionProgressionAchievement("That's Gllang!",12,15,2)
missionProgressionAchievement("From Twinjet to Trio",16,19,2)

missionProgressionAchievement("Tag Team",20,24,"")
missionProgressionAchievement("Regaining Control",25,30,"")
missionProgressionAchievement("Fight for the Georite",31,33,"")
missionProgressionAchievement("Controlling Your Destiny",34,38,"")
missionProgressionAchievement("Unlimited Power",39,40,"")
missionProgressionAchievement("Two Down, Two To Go",41,42,"")
missionProgressionAchievement("The Fourth Estate",43,45,"")
missionProgressionAchievement("Clearing the Air",46,47,"")
missionProgressionAchievement("Turning the Tide",48,50,"")
missionProgressionAchievement("A New Era of Coexistence",51,53,"")


postMissionEventAchievement("Me and Nanao","Watch the epilogue after having won Nanao's favor",10,"nanao_favor_flag",7,"v58\72a-4") //Me and Nanao. And the Meganites.
postMissionEventAchievement("Me and Ellen","Watch the epilogue after having won Ellen's favor",10,"ellen_favor_flag",2,"v58\49a-4") //Me and Ellen. And the Meganites.
postMissionEventAchievement("Me and Souya","Watch the epilogue after having won Souya's favor",10,"no_ellen_or_nanao_yui",0,"v58\95-4") //Me and Souya. And the Meganites.

postMissionEventAchievement("No! The Bakery!","In story mode, destroy the bakery 1 time between episodes 10 and 30",5,"nanao_economic_flag",1,"vev\1-3") //I wonder if they'll still pay me for this month's work
postMissionEventAchievement("Time to Find Another Job","In story mode, destroy the bakery 2 times between episodes 10 and 30",5,"nanao_economic_flag",2,"vev\4-1") //Baron Cafe seeking enthusiastic workers
postMissionEventAchievement("Can't Afford to Be Picky","In story mode, destroy the bakery 3 times between episodes 10 and 30",5,"nanao_economic_flag",3,"vev\7-1") //Exotic dance lounge Valhalla seeks floor workers
postMissionEventAchievement("This Is the Life That Grandma Chose","In story mode, destroy the bakery 4 times between episodes 10 and 30",5,"nanao_economic_flag",4,"vev\20-4") //I'm sorry, big brother ...
postMissionEventAchievement("One Hundred Billion Yen","In story mode, destroy the bakery 5 times between episodes 10 and 30",10,"nanao_economic_flag",5,"vev\31-1") //To the tune of one hundred billion yen

//TODO: Ellen date post mission achievement

postMissionEventAchievement("It Doesn't Bother Me at All","Destroy Keiko's apartment 1 time",5,"keiko_flag",1,"vev\132-1") //Well, my Condo building got destroyed in the fighting the other day
postMissionEventAchievement("It's Not a Big Deal at All","Destroy Keiko's apartment 2 time",5,"keiko_flag",2,"vev\150-1") //My condo got destroyed during the fighting, so I'm sleeping here tonight
postMissionEventAchievement("Don't Try Anything Funny","Destroy Keiko's apartment 3 time",5,"keiko_flag",3,"vev\157-1") //I'm staying here too. Because my condo was destroyed.

postMissionEventAchievement("We'll Rebuild","Destroy Misaki HQ",5,"misaki_heavy_industries_flag",1,"vev\68-2") //It'll take some money, but we'll find the financing somehow
postMissionEventAchievement("Because It Was with You","Discuss Misaki's financial ruin with Ellen",5,"misaki_heavy_industries_flag",9,"vev\71a-1") //Ellen! Is it true your engagement is off?
postMissionEventAchievement("More to Him Than Just a Spoiled Brat","Discuss Misaki's financial ruin with Misaki",10,"misaki_heavy_industries_flag",9,"vev\84-1") //Oh, it's you ...
postMissionEventAchievement("I'll Do What I Can","Discuss rebuilding MHI with Misaki",10,"misaki_heavy_industries_flag",10,"vev\113-1") //I'll do what I can, the only way I know how
postMissionEventAchievement("Still Have a Part To Play","Tell Misaki the world is about to end",11,"misaki_heavy_industries_flag",11,"vev\125-3") //MHI still has a part to play


allAwardsAchievement("One Weird Hack to More Than Double Your Income",8,1)
allAwardsAchievement("Fray in the Bay",9,3)
allAwardsAchievement("Standing the Heat",10,2)
allAwardsAchievement("Ride the Cyclone",11,2)
allAwardsAchievement("He Came Outta Nowhere",13,1)
//allAwardsAchievement("[VOID] Inferno",14,1) //Top score: 100; Volgara deals 80 city damage before player gets control, but construction minister seems doable
//TODO: Ep17 constuction minister achievement
allAwardsAchievement("Catch a Riiiiiide","15a",1)
//allAwardsAchievement("[VOID] Airborne Dominator","15b or 18a",7)
senjoWouldHaveBeenGratefulAchievement() //All achievements not possible for ep15b/18a; Peace/construction awards in Tokyo are 10/50 dmg and EVERYTHING is breakable
allAwardsAchievement("Childhood Protector",16,2)
allAwardsAchievement("You Want Misaki, You Go Through Me",17,1)
//allAwardsAchievement("[VOID] Centurion Crusher","19a or 19b",1) //TODO: May not be possible; Volgara attacks city a lot before Vavel arrives, and can't beat volgara until after meganite loses 50% health
//TODO: Genesis after reducing centurion to half health in ep19a achievement
//TODO: Misaki and misaki plant awards in ep19b achievement
allAwardsAchievement("Double Jeopardy",20,2)
allAwardsAchievement("Chicken Soup Run",21,2)
allAwardsAchievement("Expertly Evacuated",22,2)
allAwardsAchievement("Wheels on the Bus Go Round and Round",23,1)
//allAwardsAchievement("[VOID] The Dark One",24,2) //TODO: Not likely to be possible; Valdor appears independent of damage taken, and he keeps using rocket fist
assistanceNotRequiredAchievement()
allAwardsAchievement("Bye Bye Third Wheel",25,2)
allAwardsAchievement("Satellite Scrapper",26,1)
allAwardsAchievement("Gllang Is Very Sick! Don't Be Mad!",27,2)
allAwardsAchievement("Jamming Up the Jammers",28,2)
allAwardsAchievement("First Person View",29,1)
allAwardsAchievement("Keep On Truckin",30,2)
allAwardsAchievement("If Nanao Can Give 200% I Can Too",31,2)
allAwardsAchievement("I'll \"Accidentally On Purpose\" Next Time",32,2)
allAwardsAchievement("Almost A Fair Fight",33,4)
allAwardsAchievement("We Are Vavel",38,2)
//allAwardsAchievement("[VOID] Dantarion",39,1) // Best score:160; Dantarion is VERY strong flame breath will destroy buildings even if he's following you down the widest streets, and pilot starts far from launch, and launch is delayed
//TODO: Ep39 construction minister achievement
//allAwardsAchievement("[VOID] Valhalla Dawning",40,1) //Fastest: 7m12s L, 7m22s V, 8m47s G; volgara is invincible until meganite damage limit or time limit, and immediately destroys city hall
//TODO: Ep40 in under 9 min achievement
allAwardsAchievement("Baron Beatdown",41,4)
destroyedNoSatellitesAchievement() // Ep42 all awards achievement impossible, volgara can only be attacked by grenades until all satellites are destroyed
//allAwardsAchievement("[VOID] Spectral Visitation",42,2) 
allAwardsAchievement("Tower Defense",43,3) //Tough but possible; Volgara beelines to the tower, you can distract it with ranged attacks
allAwardsAchievement("Watch Your Step",44,1)
allAwardsAchievement("Rooftop Rescue",45,2)
allAwardsAchievement("Staying Above It All",46,2) //Difficult; volgara won't dodge ranged attacks, but can be distracted from his path the the buildings
//allAwardsAchievement("[VOID] Windborne Darkness",47,1) //May not be possible? 
//TODO: Confirm if Windborne Darkness should use Senjo Peace award, Construction Minister award, or needs alternate achievement
//allAwardsAchievement("[VOID] Lifesaver Express",48,1) //TODO: Not possible; episode starts with 100 damage, but can do 140 damage limit (constr minister)
//TODO: Ep48 construction minister achievement
allAwardsAchievement("Shipnapped",49,3)
//TODO: Ep50 deal over 1000 damage to volgara city achievement
allAwardsAchievement("Last Train Out of Senjo",51,1)
//TODO: Confirm ep53 can be completed by activating 3 min ability before destroying any volgara
//TODO: ep53 mission specific achievement - all awards?

allUpgradesAchievement("Vavel")
allUpgradesAchievement("Gllang")
allUpgradesAchievement("Laguiole")
allUpgradesAchievement("Pilot")

landAllAttacksAchievement("Vavel")
landAllAttacksAchievement("Laguiole")
landAllAttacksAchievement("Gllang")

singleAttackAchievement("With a Rebel Yell","vvl_available_genesis_cry",0,0x70)
singleAttackAchievement("Baby You're A Firework","glg_iron_tusk",1,0x70)
singleAttackAchievement("Launch All Missiles!","glg_all_shots_fired",1,0x6e)
singleAttackAchievement("Wolverine Would Be Proud","lio_horobi",2,0x6c)

launchAndHitEnemyAchievement()
attackDownedEnemyAchievement()
attackFallingEnemyAchievement()
blockAllAttacksAchievement()
useNormalControlsAchievement()



// RICH PRESENCE //
RPvalues={
    "game_mode":{
        0:"Story",
        1:"Challenge",
        2:"Tutorial",
        3:"Versus"
    },
    "mission_title":{
        201: "Heavy Arms Training",
        300: "Dantarion's Assault",
        700: "Versus"
    }
    
}

rich_presence_conditional_display(globalVar("current_scenario")==700,
    "{0} ({1}) is fighting {2} ({3}) in {4} (Versus)",
    rich_presence_lookup("Robot1",globalVar("match_1p_current_robot"),values["initial_robot"],"Robot1"),
    rich_presence_lookup("Pilot1",globalVar("match_1p_main_character_number"),values["main_character_number"],"Pilot1"),
    rich_presence_lookup("Robot1",globalVar("match_2p_current_robot"),values["initial_robot"],"Robot2"),
    rich_presence_lookup("Pilot1",globalVar("match_2p_main_character_number"),values["main_character_number"],"Pilot2"),
    rich_presence_lookup("Map",globalVar("map_type"),values["map_type"],"unknown")
    )

rich_presence_conditional_display(screenIndex2==0x0028e960,
//    "{0} is in Episode {1} Mission Briefing ({2})",
    "{0} is in Episode {1} Mission Briefing ({2}) T:{3}",
    rich_presence_lookup("Pilot",currentPilot,values["main_character_number"],"The Hero"),
    rich_presence_macro("Number",currentScenario),
    rich_presence_lookup("Game Mode",gameMode,RPvalues["game_mode"],"???"),
    rich_presence_value("Time",missionDuration,"FRAMES")
    )

rich_presence_conditional_display(characterDataArray!=0 && inMission() && gameMode==2,
//    "{0} is piloting {1} in {2} ({3})",
    "{0} is piloting {1} in {2} ({3}) T:{4}",
    rich_presence_lookup("Pilot",currentPilot,values["main_character_number"],"The Hero"),
    rich_presence_lookup("Meganite",currentRobot,values["initial_robot"],"the meganite"),
    rich_presence_lookup("Mission",currentScenario,RPvalues["mission_title"]),
    rich_presence_lookup("Game Mode",gameMode,RPvalues["game_mode"],"???"),
    rich_presence_value("Time",missionDuration,"FRAMES")
    )

rich_presence_conditional_display(characterDataArray!=0 && inMission() && gameMode==0,
//    "{0} is piloting {1} in Episode {2} ({3}) N♡:{6} E♡:{7} N$:{8} M$:{9} K$:{10}",
    "{0} is piloting {1} in Episode {2} ({3}) ⏲:{4} 🏠💥:{5} N♡:{6} E♡:{7} N$:{8} M$:{9} K$:{10} DMG:{11} BCP:{12}",
    rich_presence_lookup("Pilot",currentPilot,values["main_character_number"],"The Hero"),
    rich_presence_lookup("Meganite",currentRobot,values["initial_robot"],"the meganite"),
    rich_presence_macro("Number",currentScenario),
    rich_presence_lookup("Game Mode",gameMode,RPvalues["game_mode"],"???"),
    rich_presence_value("Time",missionDuration,"FRAMES"),
    rich_presence_value("Number",cityDamage),
    rich_presence_macro("Number",globalVar("nanao_favor_flag")),
    rich_presence_macro("Number",globalVar("ellen_favor_flag")),
    rich_presence_macro("Number",globalVar("nanao_economic_flag")),
    rich_presence_macro("Number",globalVar("misaki_heavy_industries_flag")),
    rich_presence_macro("Number",globalVar("keiko_flag")),
    rich_presence_value("Number",globalVar("amount_of_damage")),
    rich_presence_value("Number",globalVar("building_collapse_point"))
    )

rich_presence_conditional_display(characterDataArray!=0 && inMission() && robotIsPresent() && enemy3IsPresent(),
    "{0} is piloting {1} in Episode {2} ({3}) 🤖{5}/{6} 👾{7}/{8} 👾{9}/{10} 👾{11}/{12} ⏲:{13} 🏠💥:{14} DMG:{15} BCP:{16}",
    rich_presence_lookup("Pilot",currentPilot,values["main_character_number"],"The Hero"),
    rich_presence_lookup("Meganite",currentRobot,values["initial_robot"],"the meganite"),
    rich_presence_macro("Number",currentScenario),
    rich_presence_lookup("Game Mode",gameMode,RPvalues["game_mode"],"???"),
    rich_presence_value("Time",missionDuration,"FRAMES"),
    rich_presence_value("Robot Health",robot["health"]),
    rich_presence_value("Robot Max Health",robot["max_health"]),
    rich_presence_value("Enemy Health",enemy["health"]),
    rich_presence_value("Enemy Max Health",enemy["max_health"]),
    rich_presence_value("Enemy2 Health",enemy2["health"]),
    rich_presence_value("Enemy2 Max Health",enemy2["max_health"]),
    rich_presence_value("Enemy3 Health",enemy3["health"]),
    rich_presence_value("Enemy3 Max Health",enemy3["max_health"]),
    rich_presence_value("Time",missionDuration,"FRAMES"),
    rich_presence_value("Number",cityDamage),
    rich_presence_value("Number",globalVar("amount_of_damage")),
    rich_presence_value("Number",globalVar("building_collapse_point"))
    
    )
rich_presence_conditional_display(characterDataArray!=0 && inMission() && robotIsPresent() && enemy2IsPresent(),
    "{0} is piloting {1} in Episode {2} ({3}) Time:{4} 🤖{5}/{6} 👾{7}/{8} 👾{9}/{10} ⏲:{11} 🏠💥:{12} DMG:{13} BCP:{14}",
    rich_presence_lookup("Pilot",currentPilot,values["main_character_number"],"The Hero"),
    rich_presence_lookup("Meganite",currentRobot,values["initial_robot"],"the meganite"),
    rich_presence_macro("Number",currentScenario),
    rich_presence_lookup("Game Mode",gameMode,RPvalues["game_mode"],"???"),
    rich_presence_value("Time",missionDuration,"FRAMES"),
    rich_presence_value("Robot Health",robot["health"]),
    rich_presence_value("Robot Max Health",robot["max_health"]),
    rich_presence_value("Enemy Health",enemy["health"]),
    rich_presence_value("Enemy Max Health",enemy["max_health"]),
    rich_presence_value("Enemy2 Health",enemy2["health"]),
    rich_presence_value("Enemy2 Max Health",enemy2["max_health"]),
    rich_presence_value("Time",missionDuration,"FRAMES"),
    rich_presence_value("Number",cityDamage),
    rich_presence_value("Number",globalVar("amount_of_damage")),
    rich_presence_value("Number",globalVar("building_collapse_point"))
    )

rich_presence_conditional_display(characterDataArray!=0 && heroIsPresent() && robotIsPresent(),
    "{0} is piloting {1} in Episode {2} ({3}) 🤖{5}/{6} 👾{7}/{8} ⏲:{9} 🏠💥:{10}",
    rich_presence_lookup("Pilot",currentPilot,values["main_character_number"],"The Hero"),
    rich_presence_lookup("Meganite",currentRobot,values["initial_robot"],"the meganite"),
    rich_presence_macro("Number",currentScenario),
    rich_presence_lookup("Game Mode",gameMode,RPvalues["game_mode"],"???"),
    rich_presence_value("Time",missionDuration,"FRAMES"),
    rich_presence_value("Robot Health",robot["health"]),
    rich_presence_value("Robot Health",robot["max_health"]),
    rich_presence_value("Robot Health",enemy["health"]),
    rich_presence_value("Robot Health",enemy["max_health"]),
    rich_presence_value("Time",missionDuration,"FRAMES"),
    rich_presence_value("Number",cityDamage),
    rich_presence_value("Number",globalVar("amount_of_damage")),
    rich_presence_value("Number",globalVar("building_collapse_point"))
    )

    
rich_presence_conditional_display(characterDataArray!=0 && heroIsPresent() && robotIsPresent(),
//    "{0} is piloting {1} in Episode {2} ({3})",
    "{0} is piloting {1} in Episode {2} ({3}) ⏲:{4} 🏠💥:{5} DMG:{6} BCP:{7}",
    rich_presence_lookup("Pilot",currentPilot,values["main_character_number"],"The Hero"),
    rich_presence_lookup("Meganite",currentRobot,values["initial_robot"],"the meganite"),
    rich_presence_macro("Number",currentScenario),
    rich_presence_lookup("Game Mode",gameMode,RPvalues["game_mode"],"???"),
    rich_presence_value("Time",missionDuration,"FRAMES"),
    rich_presence_value("Robot Health",robot["health"]),
    rich_presence_value("Robot Health",robot["max_health"]),
    rich_presence_value("Robot Health",enemy["health"]),
    rich_presence_value("Robot Health",enemy["max_health"]),
    rich_presence_value("Time",missionDuration,"FRAMES"),
    rich_presence_value("Number",cityDamage),
    rich_presence_value("Number",globalVar("amount_of_damage")),
    rich_presence_value("Number",globalVar("building_collapse_point"))
    )
rich_presence_conditional_display(characterDataArray!=0 && heroIsPresent(),
//    "{0} is in Episode {1} ({2})",
    "{0} is in Episode {1} ({2}) ⏲:{3} 🏠💥:{4} DMG:{5} BCP:{6}",
    rich_presence_lookup("Pilot",currentPilot,values["main_character_number"],"The Hero"),
    rich_presence_macro("Number",currentScenario),
    rich_presence_lookup("Game Mode",gameMode,RPvalues["game_mode"],"???"),
    rich_presence_value("Time",missionDuration,"FRAMES"),
    rich_presence_value("Number",cityDamage),
    rich_presence_value("Number",globalVar("amount_of_damage")),
    rich_presence_value("Number",globalVar("building_collapse_point"))
    )

//rich_presence_display("No! The Bakery! That's where I work! ")


rich_presence_display("Last played Episode {0} ({1}) mode:{6} T:{7} index1:{2} index2:{3} index3:{4} index4:{5} intial:{8} current:{9}",
    rich_presence_macro("Number",globalVar("current_scenario")),
    rich_presence_lookup("Game Mode",gameMode,RPvalues["game_mode"],"???"),
    rich_presence_macro("Number",screenIndex1),
    rich_presence_macro("Number",screenIndex2),
    rich_presence_macro("Number",screenIndex3),
    rich_presence_macro("Number",screenIndex4),
    rich_presence_macro("Number",gameMode),
    rich_presence_value("Time",missionDuration,"FRAMES"),
    rich_presence_value("Number",globalVar("initial_robot")),
    rich_presence_value("Number",globalVar("current_robot"))

    )


//Debugging RPs//


/*
//Global vars debugging
rpDisplayText = ""
index = 0
for index in [12,1,10,11,3,4,5,6,8,43]{ 
    rpDisplayText = rpDisplayText + variables[index] + ": {" + index + "}, "
}
    
    rich_presence_display(rpDisplayText,
    rich_presence_macro("Number",dword(nodes["main_character_number"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["initial_robot"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["control_type"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["ellen_favor_flag"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["nanao_favor_flag"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["nanao_economic_flag"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["keiko_flag"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["banhara_death_flag"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["misaki_heavy_industries_flag"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["nanao_amulet_flag"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["work"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["temporary_event"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["current_scenario"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["after_the_day_of_the_gods_destruction"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["number_of_continues"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["current_robot"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["map_type"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["amount_of_damage"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["collapse_senjo_city_hall"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["collapse_misaki_heavy_industries_headquarters_building"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["collapse_misaki_heavy_industries_senjo_factory"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["collapse_misaki_heavy_industries_research_institute"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["collapse_senjo_hospital"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["collapse_tsukioka_industries_headquarters"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["collapse_evacuation_guidance_team_headquarters"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["collapse_stadium"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["collapse_senjo_station"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["collapse_civilization_preservation_foundation"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["collapse_minami_senjo_station"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["collapse_supermarket"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["collapse_bakery"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["collapse_coffee_shop"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["collapse_observatory"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["collapse_bnn_senjo_branch"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["collapse_nanaho_s_house"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["collapse_kaoruko_s_apartment"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["collapse_nanaho_s_apartment"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["collapse_otawara_trading"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["collapse_ellen_s_apartment"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["collapse_banbara_s_apartment"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["collapse_tokyo_metropolitan_government_building"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["collapse_school"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["collapse_yaoya"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["building_collapse_point"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["frost_beam"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["hero_money"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["hero_shield"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["hero_booster"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["hero_drive"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["hero_grenade"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["vvl_armor_reinforcement"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["vvl_gigantic_booster"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["vvl_dual_knuckle"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["vvl_dive"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["vvl_wavel_missile"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["vvl_pyro_burner"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["vvl_gravity_zero"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["vvl_divine_upper"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["vvl_blast_hook"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["lio_armor_reinforcement"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["lio_gigantic_boomerang"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["lio_horobi"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["lio_sky_torpedo"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["lio_aerial_missile"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["lio_divine_laser"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["lio_gravity_zero"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["glg_armor_reinforcement"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["glg_machine_cannon"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["glg_all_shots_fired"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["glg_gaia_axe"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["glg_iron_tusk"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["glg_detonator"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["glg_shoulder_missile"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["glg_leg_missile"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["glg_gravity_zero"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["glg_machine_cannon_ammo_count"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["vvl_available_genesis_mode"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["vvl_available_genesis_cry"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["lio_available_reinforcement"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["glg_available_reinforcement"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["battle_map_number"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["match_1p_main_character_number"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["match_2p_main_character_number"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["match_1p_control_type"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["match_2p_control_type"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["match_1p_current_robot"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["match_2p_current_robot"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["mc_lastaccess"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["system_lastaccessdataindex"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["system_is_stereo"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["system_is_vibration"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["system_is_monitor_vibration"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["system_is_animated_gore"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["system_vs_robo"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["system_vs_map"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["game_mode"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["system_boot_game_data_num"]+0x1c)),
    rich_presence_macro("Number",dword(nodes["language"]+0x1c)))
    
*/



