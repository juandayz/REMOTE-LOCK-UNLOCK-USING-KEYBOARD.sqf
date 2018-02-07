private ["_time","_vehicleType","_onLadder","_vehicle","_canDo","_vehicleOwnerID","_totalKeys","_temp_keys","_temp_keys_names","_hasKey","_oldOwner","_uid"];
_vehicle = cursorTarget;
_vehicleType = typeOf _vehicle;

if (dayz_actionInProgress) exitWith {"Your remote control is stuked. wait a few seconds" call dayz_rollingMessages;};

_vehicle = cursorTarget;
_vehicleType = typeOf _vehicle;
_onLadder = (getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1; 
_canDo = (!r_drag_sqf && !r_player_unconscious && !_onLadder);
_vehicleOwnerID = _vehicle getVariable ["CharacterID","0"];
if !(_vehicle isKindOf "AllVehicles" && {player distance _vehicle < 50}) exitWith {};
if (!alive _vehicle) exitWith {systemchat "<REMOTE_KEY>:VEHICLE DAMAGED";};
if !(_vehicleOwnerID != "0" && _canDo) exitWith {systemchat "<REMOTE_KEY>:SOMETHING WRONG WITH YOU OR YOUR VEHICLE";};
//update by juandayz for free :D
_totalKeys = call epoch_tempKeys;
_temp_keys = _totalKeys select 0;
_temp_keys_names = _totalKeys select 1;	
_hasKey = _vehicleOwnerID in _temp_keys;
_uid = getPlayerUID player;
_oldOwner = (_vehicleOwnerID == _uid);
if !(_hasKey or _oldOwner) exitWith {systemchat "<REMOTE_KEY>:YOUR NOT THE OWNER OF THE VEHICLE OR YOU MISS THE KEY";};


//if is locked
player playActionNow "GesturePoint";
dayz_actionInProgress = true;
//null = [objNull,_vehicle,rSAY,"carLock",80] call RE;
if(locked _vehicle) then {

{player removeAction _x} count s_player_lockunlock;s_player_lockunlock = [];
s_player_lockUnlock_crtl = 1;

PVDZE_veh_Lock = [_vehicle,false];
_time = diag_tickTime;

if (local _vehicle) then {
//PVDZE_veh_Lock spawn local_lockUnlock;
PVDZE_veh_Lock call local_lockUnlock;
} else {
publicVariable "PVDZE_veh_Lock";
};


format["Your %1  Has been unlocked.",_vehicleType] call dayz_rollingMessages;

waitUntil {uiSleep 0.1;(!locked _vehicle or (diag_tickTime - _time > 4))};
s_player_lockUnlock_crtl = -1;


}else{ 
//If is unlocked

{player removeAction _x} count s_player_lockunlock;s_player_lockunlock = [];
s_player_lockUnlock_crtl = 1;


PVDZE_veh_Lock = [_vehicle,true];
_time = diag_tickTime;

{
_x action ["eject",_vehicle];
systemChat format ["%1 is out from your vehicle",name _x];
} forEach (crew _vehicle);


if (local _vehicle) then {

PVDZE_veh_Lock call local_lockUnlock;
} else {
publicVariable "PVDZE_veh_Lock";
};


format["Your %1  Has been locked.",_vehicleType] call dayz_rollingMessages;

waitUntil {uiSleep 0.1;(locked _vehicle or (diag_tickTime - _time > 4))};
s_player_lockUnlock_crtl = -1;


};
Sleep 2; 
dayz_actionInProgress = false;
