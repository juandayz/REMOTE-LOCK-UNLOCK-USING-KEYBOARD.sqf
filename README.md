# REMOTE-LOCK-UNLOCK-USING-KEYBOARD.sqf

***I dont wanna hear any idiot saying: "you stole my code you stole my code" ..."When the stuff happened with my remote vehicle core that Juan used without permission/credits he had it merged...blabla"...***

All codes comes from default fn_selfactions.sqf and default  unlock_veh.sqf   and the original idea and credits goes to @David
https://epochmod.com/forum/topic/10843-release-remote-key-for-lockingunlocking-vehicles-03/

If u wanna feel like a genious just be a genious not an idiot blaming others for things you know are not true.


WHAT IS DOES?- Allow players to lock unlock vehicles pressing "T" key. Dsnt need all that shit about right clicks.
Remove all default actions from lock unlock with scroll menu and all actions from inside vehicle too.

**INSTALL:**

1-YOu will need a custom keyboard.sqf

2-Open your custom Keyboard.sqf and at very bottom but before the last _handle  paste:

```ruby
if (_dikCode ==  0x14) then {[]execVM "scripts\remotekey\remote_key.sqf";}; //T key for lock unlock veh
```

3.Open your custom fn_selfactions.sqf

A-Find:

```
if (_inVehicle) then {
	DZE_myVehicle = _vehicle;
	if (_vehicleOwnerID != "0" && _canDo) then {
		if (s_player_lockUnlockInside_ctrl < 0) then {
			_totalKeys = call epoch_tempKeys;
			_temp_keys = _totalKeys select 0;
			_temp_keys_names = _totalKeys select 1;	
			_hasKey = _vehicleOwnerID in _temp_keys;
			_oldOwner = (_vehicleOwnerID == _uid);

			_text = getText (configFile >> "CfgVehicles" >> (typeOf DZE_myVehicle) >> "displayName");
			if (locked DZE_myVehicle) then {
				if (_hasKey || _oldOwner) then {
					_unlock = DZE_myVehicle addAction [format[localize "STR_EPOCH_ACTIONS_UNLOCK",_text], "\z\addons\dayz_code\actions\unlock_veh.sqf",[DZE_myVehicle,(_temp_keys_names select (_temp_keys find _vehicleOwnerID))], 2, false, true];
					s_player_lockUnlockInside set [count s_player_lockUnlockInside,_unlock];
					s_player_lockUnlockInside_ctrl = 1;
				} else {
					if (_hasHotwireKit) then {
						_unlock = DZE_myVehicle addAction [format[localize "STR_EPOCH_ACTIONS_HOTWIRE",_text], "\z\addons\dayz_code\actions\hotwire_veh.sqf",DZE_myVehicle, 2, true, true];
					} else {
						_unlock = DZE_myVehicle addAction [format["<t color='#ff0000'>%1</t>",localize "STR_EPOCH_ACTIONS_VEHLOCKED"], "",DZE_myVehicle, 2, true, true];
					};
					s_player_lockUnlockInside set [count s_player_lockUnlockInside,_unlock];
					s_player_lockUnlockInside_ctrl = 1;
				};
			} else {
				if (_hasKey || _oldOwner) then {
					_lock = DZE_myVehicle addAction [format[localize "STR_EPOCH_ACTIONS_LOCK",_text], "\z\addons\dayz_code\actions\lock_veh.sqf",DZE_myVehicle, 1, false, true];
					s_player_lockUnlockInside set [count s_player_lockUnlockInside,_lock];
					s_player_lockUnlockInside_ctrl = 1;
				};
			};
		};
	} else {
		{DZE_myVehicle removeAction _x} count s_player_lockUnlockInside;s_player_lockUnlockInside = [];
		s_player_lockUnlockInside_ctrl = -1;
	};
} else {
	{DZE_myVehicle removeAction _x} count s_player_lockUnlockInside;s_player_lockUnlockInside = [];
	s_player_lockUnlockInside_ctrl = -1;
};
```
Change the whole block by: 

```ruby
if (_inVehicle) then {
	DZE_myVehicle = _vehicle;
	};
```

B: Find:
```
	// Allow Owner to lock and unlock vehicle  
	if (_player_lockUnlock_crtl) then {
		if (s_player_lockUnlock_crtl < 0) then {
			_totalKeys = call epoch_tempKeys;
			_temp_keys = _totalKeys select 0;
			_temp_keys_names = _totalKeys select 1;
			_hasKey = _characterID in _temp_keys;
			_oldOwner = (_characterID == _uid);
			if (_isLocked) then {
				if (_hasKey || _oldOwner) then {
					_unlock = player addAction [format[localize "STR_EPOCH_ACTIONS_UNLOCK",_text], "\z\addons\dayz_code\actions\unlock_veh.sqf",[_cursorTarget,(_temp_keys_names select (_temp_keys find _characterID))], 2, true, true];
					s_player_lockunlock set [count s_player_lockunlock,_unlock];
					s_player_lockUnlock_crtl = 1;
				} else {
					if (_hasHotwireKit) then {
						_unlock = player addAction [format[localize "STR_EPOCH_ACTIONS_HOTWIRE",_text], "\z\addons\dayz_code\actions\hotwire_veh.sqf",_cursorTarget, 2, true, true];
					} else {
						_unlock = player addAction [format["<t color='#ff0000'>%1</t>",localize "STR_EPOCH_ACTIONS_VEHLOCKED"], "",_cursorTarget, 2, false, true];
					};
					s_player_lockunlock set [count s_player_lockunlock,_unlock];
					s_player_lockUnlock_crtl = 1;
				};
			} else {
				if (_hasKey || _oldOwner) then {
					_lock = player addAction [format[localize "STR_EPOCH_ACTIONS_LOCK",_text], "\z\addons\dayz_code\actions\lock_veh.sqf",_cursorTarget, 1, true, true];
					s_player_lockunlock set [count s_player_lockunlock,_lock];
					s_player_lockUnlock_crtl = 1;
				};
			};
		};
	} else {
		{player removeAction _x} count s_player_lockunlock;s_player_lockunlock = [];
		s_player_lockUnlock_crtl = -1;
	};
  ```
  
  Replace the whole block by:
  
  ```ruby
  	// Allow Owner to lock and unlock vehicle  
	if (_player_lockUnlock_crtl) then {
		_totalKeys = call epoch_tempKeys;
		_temp_keys = _totalKeys select 0;
		_temp_keys_names = _totalKeys select 1;
		_hasKey = _characterID in _temp_keys;
		
		if (s_player_lockUnlock_crtl < 0) then {
			_oldOwner = (_characterID == _uid);
			if (_isLocked) then {
				if (_hasKey || {_oldOwner}) then {
					_temp_key_name = (_temp_keys_names select (_temp_keys find _characterID));
					_unlock = player addAction [format["<t color='#0041f0'>PRESS T FOR UNLOCK</t>"], "",_cursorTarget, 2, false, true];					
					s_player_lockunlock set [count s_player_lockunlock,_unlock];
					s_player_lockUnlock_crtl = 1;
				} else {
                    _unlock = player addAction [format["<t color='#ff0000'>%1</t>",localize "STR_EPOCH_ACTIONS_VEHLOCKED"], "",_cursorTarget, 2, false, true];					
					s_player_lockunlock set [count s_player_lockunlock,_unlock];
					s_player_lockUnlock_crtl = 1;
				};
			} else {
				if (_hasKey || _oldOwner) then {
				    _lock = player addAction [format["<t color='#ff0000'>PRESS T FOR LOCK</t>"], "",_cursorTarget, 2, false, true];	
					s_player_lockunlock set [count s_player_lockunlock,_lock];
					s_player_lockUnlock_crtl = 1;
				};
			};
		};
	} else {
		{player removeAction _x} count s_player_lockunlock;s_player_lockunlock = [];
		s_player_lockUnlock_crtl = -1;
};
```

4.Drop remotekey folder into your scripts folder.
