// Zork III: The Dungeon Master
// #ID = 18585

//Player/item locations
cur_location={
    "player":byte(0x3801),
    "staff":byte(0x31fe),
    "book":byte(0x3768),
    "hood":byte(0x3339),
    "amulet":byte(0x3246),
    "ring":byte(0x33c9),
    "key":byte(0x3126),
    "vial":byte(0x3102)
}

//Point flags
point_flags={
    "chest":byte(0x4d49),
    "sword":byte(0x4d57),
    "attack":byte(0x4d55),
    "lake":byte(0x4d39),
    "table":byte(0x4d33),
    "tm":byte(0x4d83),
    "puzzle":byte(0x4dd1)
}

//Other
mode_selected = byte(0x22)
starting_up = byte(0x37fa)
score = byte(0x4d13)
move_counter = word_be(0x4d14)
failure_counter = byte(0x4e01)
cur_year = word_be(0x4d8c)
last_command = 0x50e9 // 100-byte ASCII array

//Functions
function bronze_door_unlocked() => byte(0x4d99)==0
function secret_door_revealed() => bit3(0x3662)==0x0 && prev(bit3(0x3662))==0x1 //0=visible, 1=invisible
function is_invisible() => byte(0x4d19)==0x1
function ring_retrieved_from_seat() => byte(0x4d85)==0 && prev(byte(0x4d85))==1
function ring_stolen() => byte(0x4d7b)==1 && prev(byte(0x4d7b))==0
function vial_appears() => cur_location["vial"]==0x44 && prev(cur_location["vial"])==0x0
function overheard_flathead() => byte(0x4d7d)==1 && prev(byte(0x4d7d))==0
function has_item(item) => cur_location[item]==0xca
function had_item(item) => prev(cur_location[item])==0xca
function in_location(place) => cur_location["player"]==place
function location_changes() => cur_location["player"]!=prev(cur_location["player"])
function ring_stolen_plaque_read() => (dword(0x20c)==0xf4e9f7ae && dword(0x210)==0xa0eee9e8 && dword(0x214)==0xefeca0e1 && prev(dword(0x20c))!=0xf4e9f7ae) //80 lines
                                   || (dword(0x20c)==0xd2d5d0a0 && dword(0x210)==0xc5d3cfd0 && dword(0x214)==0xc6c9c3ae && prev(dword(0x20c))!=0xd2d5d0a0) //40 lines
function flathead_sentence() => (dword(0x20c)==0xcfc9d3d3 && dword(0x210)==0xadada0ce && dword(0x214)==0xaaaaa0a0 && prev(dword(0x20c))!=0xcfc9d3d3) //40/80 lines
function robot_appeared() => (dword(0x20c)==0xe5f2e1a0 && dword(0x210)==0xf3f4e9a0 && dword(0x214)==0xf3e1eca0 && prev(dword(0x20c))!=0xe5f2e1a0) //80 lines
                          || (dword(0x20c)==0xcfd2a0c5 && dword(0x210)==0xa0accdcf && dword(0x214)==0xd3cfccc3 && prev(dword(0x20c))!=0xcfd2a0c5) //40 lines
function failure_counter_increment() => failure_counter==prev(failure_counter)+1

function flag_change(flag){
    if(flag=="table"){
        return point_flags["table"]==0x0 && prev(point_flags["table"])==0x1
    }else{
        return point_flags[flag]==0x1 && prev(point_flags[flag])==0x0
    }
}

function get_item(item,from_location=""){
    if(from_location=="") return has_item(item) && !had_item(item)
    else return has_item(item) && prev(cur_location[item])==from_location
}

function not_in_key_locations(){
    return cur_location["player"]!=0x0a // High Arch
        && cur_location["player"]!=0x0b // Aqueduct
        && cur_location["player"]!=0x0c // Key Room
        && cur_location["player"]!=0x0d // Dark Place (S)
        && cur_location["player"]!=0x0e // Dark Place (N)
}

function in_key_locations(){
    return cur_location["player"]>=0x0a && cur_location["player"]<=0x0e
}

function contempt_prereqs(){
    return once(in_key_locations() && failure_counter_increment() && cur_location["key"]==0x1d) && never(cur_location["key"]==0x0c) && never(last_command_was_game_restored() && restore_successful())
}

function enter_location(to,from=""){
    if(from=="") return in_location(to) && prev(cur_location["player"])!=to
    else return in_location(to) && prev(cur_location["player"])==from
}

function last_command_was_game_restored(){
    restore_string_array = [0x72,0x65,0x73,0x74,0x6f,0x72,0x65,0x0d] //restore/r
    return all_of(range(0, length(restore_string_array) - 1), i => byte(last_command + i) == restore_string_array[i])
}

function last_command_was_game_saved(){
    save_string_array = [0x73,0x61,0x76,0x65,0x0d] //save/r
    return all_of(range(0, length(save_string_array) - 1), i => byte(last_command + i) == save_string_array[i])
}

function prev_command_was_game_restored(){
    restore_string_array = [0x72,0x65,0x73,0x74,0x6f,0x72,0x65,0x0d] //restore/r
    return all_of(range(0, length(restore_string_array) - 1), i => prev(byte(last_command + i)) == restore_string_array[i])
}

function last_command_was_game_restarted(){
    restart_string_array = [0x72,0x65,0x73,0x74,0x61,0x72,0x74,0x0d] //restart/r
    return all_of(range(0, length(restart_string_array) - 1), i => byte(last_command + i) == restart_string_array[i])
}

function game_restore_complete(){
    return last_command_was_game_saved() && prev_command_was_game_restored() && byte(0x3f)==0x51
}

function restore_successful() => byte(0x3f)==0x5b

function player_just_died(){
    return once(failure_counter_increment())
        && never(
            repeated(2,move_counter>prev(move_counter) && never(failure_counter_increment()))
           )
}

function ga(ach_title,ach_desc,achpoints,triggers,prevent_restore=true,ach_type=""){
    if(prevent_restore) triggers = triggers && unless(last_command_was_game_restored())
    achievement(
        title = ach_title,
        description = ach_desc,
        points = achpoints,
        trigger = triggers,
        type=ach_type
        //id=0,
        //published="",
        //modified="",
        //badge="0",
        //set=0
    )
}

ga("Live Die Repeat","Restore a saved game immediately after dying. Don't forget to save early and often!",1,player_just_died() && game_restore_complete(),false)
ga("So Close and Yet","Earn a point for discovering a treasure chest",1,flag_change("chest"),ach_type="progression")
ga("A Sword That Shines with a Cold Light","Earn a point for recovering a legendary blade",1,flag_change("sword"),ach_type="progression")
ga("A Hit, a Very Palpable Hit","Earn a point for standing your ground",1,flag_change("attack"),ach_type="progression")
ga("Leave the Lantern","Earn a point for taking a plunge",1,flag_change("lake"),ach_type="progression")
ga("Blue Skidoo","Earn a point for immersing yourself in the experience",1,flag_change("table"),ach_type="progression")
ga("We Don't Need Roads","Earn a point for working backwards",1,flag_change("tm"),ach_type="progression")
ga("Pushing Your Luck","Earn a point for ignoring written warnings",1,flag_change("puzzle"),ach_type="progression")
ga("Trial of Trust","Receive a reward for helping a \"friend\"",5,get_item("staff",0x00),ach_type="progression")
ga("Trial of Compassion","Reveal the identity of the hooded figure",3,get_item("hood",0x43),ach_type="progression")
ga("Trial of Fortune","Recover an underwater treasure",2,get_item("amulet",0x00),ach_type="progression")
ga("Trial of Swiftness","Obtain a strange key and return safely",5,has_item("key") && enter_location(0x98,0x09))
ga("Trial of Ingenuity","Steal a priceless artifact",5,ring_stolen(),ach_type="progression")
ga("Trial of Patience","Retrieve an item from the Royal Puzzle",5,(has_item("book") || cur_location["book"]==0xc3) && enter_location(0xc9,0xc1),ach_type="progression")
ga("Trial of Kindness","Aid a weary traveler",3,secret_door_revealed(),ach_type="progression")
ga("Trial of Valor","Avoid the notice of the Guardians",5,enter_location(0x90,0x9e) || enter_location(0x90,0xae),ach_type="")
ga("The Final Test","Prove yourself worthy of the final test",3,enter_location(0xb2,0x90),ach_type="progression")
ga("Dungeon Master","Discover the Treasury of Zork",25,enter_location(0x85,0x87) && bronze_door_unlocked(),ach_type="win_condition")
ga("Nothing Happens Here","Get the attention of a lone mariner",5,vial_appears(),ach_type="missable")
ga("Extreme Valor","Stare into the face of danger while passing the Guardians",5,enter_location(0xae,0xac),ach_type="missable")
ga("Contempt of Swiftness","Recover the strange key after jumping off the aqueduct",5,contempt_prereqs() && get_item("key",0x1d) && not_in_key_locations(),ach_type="missable")
ga("Personalized Accommodations","Receive custom-built lodgings from Lord Dimwit Flathead",3,flathead_sentence(),prevent_restore=false)
ga("OZMOO SELF","Enter the sacrificial altar without an exit plan",1,enter_location(0x10,0x2b))
ga("Must Be a Lot of Open Windows Somewhere","Find out who keeps closing doors in the museum",5,robot_appeared(),prevent_restore=false)
ga("A Hell of a Mystery No One Thought Was a Mystery","Discover how one of the treasures of Zork 2 ended up in a volcano",3,ring_stolen_plaque_read(),prevent_restore=false)
ga("#3 Just Has a Nice Ring to It","Overhear an omnipotent local tyrant discussing the creation of a very impressive structure",5,overheard_flathead())

leaderboard("Master Initiate","Complete the game in the fewest moves.", enter_location(0x85,0x87) && bronze_door_unlocked(), always_false(), always_true(), move_counter, format="VALUE", lower_is_better=true)

RPvalues={
    "location":{
        0x00:"Uninitialized", // items only
        0x09:"Water Slide",
        0x0a:"High Arch",
        0x0b:"Aqueduct",
        0x0c:"Key Room",
        0x0d:"Dark Place", // S
        0x0e:"Dark Place", // N
        0x0f:"Southern Shore",
        0x10:"Sacrificial Altar", // Enchanter
        0x12:"Room 8", // Zork II
        0x13:"Machine Room", // Zork 1
        0x14:"Drafty Room", // Zork 1
        0x15:"Dead End", // Zork I
        0x16:"Ladder Bottom", // Zork 1
        0x18:"Ladder Top", // Zork 1
        0x19:"Timber Room", // Zork 1
        0x1d:"Inside Chest", // items only
        0x2b:"Scenic Vista",
        0x2d:"Western Shore",
        0x2e:"Underwater",
        0x30:"On the Lake",
        0x32:"Aqueduct View",
        0x34:"Lake Shore",
        0x35:"Foggy Room",
        0x37:"Cliff Ledge",
        0x3a:"Cliff",
        0x3c:"Cliff Base",
        0x3d:"Hairpin Loop",
        0x3e:"Barren Area",
        0x3f:"Junction",
        0x40:"Endless Stair",
        0x43:"Hooded figure", // items only
        0x44:"Flathead Ocean",
        0x45:"Land of Shadow", // NW
        0x46:"Land of Shadow", // W
        0x47:"Land of Shadow", // SW
        0x48:"Land of Shadow", // Quicksand
        0x49:"Land of Shadow", // S
        0x4a:"Land of Shadow", // Center
        0x4c:"Land of Shadow", // N
        0x4d:"Land of Shadow", // E
        0x4e:"Creepy Crawl",
        0x54:"Pedestal", // items only
        0x5b:"Sitting in Gold Machine",
        0x5c:"Museum Entrance", // 776 GUE
        0x5d:"Jewel Room", // 776 GUE
        0x5f:"Technology Museum", // 776 GUE
        0x60:"Technology Museum", // 883-947 GUE
        0x61:"Jewel Room", // 883-947 GUE
        0x62:"Museum Entrance", // 883-947 GUE
        0x63:"Side Room", // 883-947 GUE
        0x64:"Royal Puzzle Entrance", // 883-947 GUE
        0x65:"Technology Museum", // 948-999 GUE
        0x66:"Jewel Room", // 948-999 GUE
        0x69:"Museum Entrance", // 948-999 GUE
        0x6c:"Great Door",
        0x6e:"Royal Hall",
        0x70:"Crystal Grotto",
        0x71:"Tight Squeeze",
        0x85:"Treasury of Zork",
        0x87:"Prison Cell", // Rotated cell w/ bronze door; exits to Treasury
        0x89:"Prison Cell", // Rotated cell w/o bronze door; no exit
        0x8a:"Prison Cell", // From North Corridor
        0x8b:"Parapet",
        0x8f:"North Corridor",
        0x90:"Dungeon Entrance",
        0x93:"South Corridor",
        0x94:"West Corridor",
        0x95:"East Corridor",
        0x98:"Damp passage",
        0x99:"Dead End",
        0x9a:"Engravings Room",
        0x9b:"Beam Room",
        0x9d:"Button Room",
        0x9e:"Inside Mirror",
        0x9f:"Narrow Room", // W of Hallway 1
        0xa0:"Narrow Room", // E of Hallway 1
        0xa1:"Narrow Room", // W of Hallway 2
        0xa2:"Narrow Room", // E of Hallway 2
        0xa3:"Narrow Room", // W of Hallway 3
        0xa4:"Narrow Room", // E of Hallway 3
        0xa7:"Narrow Room", // W of Hallway 5
        0xa8:"Narrow Room", // E of Hallway 5
        0xa9:"Hallway", // 1
        0xaa:"Hallway", // 2
        0xab:"Hallway", // 3
        0xac:"Hallway", // 4
        0xae:"Hallway", // 5
        0xb2:"Narrow Corridor",
        0xc1:"Room in a Puzzle",
        0xc3:"Side Room", // 948-999 GUE
        0xc9:"Royal Puzzle Entrance",
        0xca:"In inventory", // items only
        0xc4:"Stone", // items only
    }
}


rich_presence_conditional_display(cur_year!=948 && mode_selected==1 && starting_up!=0xca,
    "{0} ({3} GUE) {1}/7 in {2} moves",
    rich_presence_lookup("Location",cur_location["player"],RPvalues["location"],"???"),
    rich_presence_value("Number",score),
    rich_presence_value("Number",move_counter),
    rich_presence_value("Number",cur_year)
    )

rich_presence_conditional_display(mode_selected==1 && starting_up!=0xca,
    "{0} {1}/7 in {2} moves",
    rich_presence_lookup("Location",cur_location["player"],RPvalues["location"],"???"),
    rich_presence_value("Number",score),
    rich_presence_value("Number",move_counter)
)

rich_presence_display("Tumbling down a great, dark staircase ...")