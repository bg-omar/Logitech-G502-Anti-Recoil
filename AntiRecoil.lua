--     [Capslock]
-- To enable/disable the script & reset fine-tune.
-- Copy this entire file into LGhub script
-- or copy only the following line into LGhub script (without --)

-- dofile("C:/path/to/this/file/AntiRecoil.lua")

-- This will load/run the script with ability to use a IDE

----------- Fine-tune amount of recoil --------
-- left [Shift] + mouse click = +Y
-- left  [Ctrl] + mouse click = -Y

----------- Fine-tune time between shots --------
-- right [Shift] + mouse click = +T
-- right  [Ctrl] + mouse click = -T

-- Show output in Logitech-Ghub console
logging = true

initial_Class = "hip_fire"
initial_Weapon = "H0650"

local NoRecoil = {}
NoRecoil.__index = NoRecoil
setmetatable(NoRecoil, {
    __call = function(cls, ...)
        return cls.new(...)
    end,
})

-- values for guns, where { move X, move Y, delay time}
local presets = {
    ["H0300"] = {0, 20, 200},
    ["Z0300"] = {0, 15, 200},

    ["H0650"] = {0, 12, 92},
    ["Z0650"] = {0, 9, 92},

    ["H0750"] = {0, 17, 80},
    ["Z0750"] = {0, 8, 80},

    ["H0900"] = {0, 18, 66},
    ["Z0900"] = {0, 9, 66},

    ["H1100"] = {0, 12, 54},
    ["Z1100"] = {0, 9, 54},
}

-- Below are the classes H = hipfire Z = zoomed
-- H1100 = hipfire for SMG with 1100 bullets per minute
-- Z300 = Zoomed for Shotgun with 300 Bullets per minute
local classes = { ["hip_fire"] =  { ["H1100"] = presets.H1100,
                                    ["H0900"] = presets.H0900,
                                    ["H0750"] = presets.H0750,
                                    ["H0650"] = presets.H0650,
                                    ["H0300"] = presets.H0300,},

                  ["zoomed"] =   {  ["Z1100"] = presets.Z1100,
                                    ["Z0900"] = presets.Z0900,
                                    ["Z0750"] = presets.Z0750,
                                    ["Z0650"] = presets.Z0650,
                                    ["Z0300"] = presets.Z0300,}
}

-- <~~constructor~~>
function NoRecoil.new(selectedClass, Gun, setPresets, setClasses)
    if logging then OutputLogMessage("\n\n\n\n\n\n ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ NoRecoil.new ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n") end
    local self = setmetatable({}, NoRecoil)
    self.Presets = setPresets
    self.Classes = setClasses
    self.classIndex = selectedClass
    self.GunIndex = Gun
    self.Gun = self.Classes[self.classIndex][self.GunIndex]
    self.noRecoilBool = false
    g = 2
    c = 1
    YY = 0
    TT = 0
    if logging then OutputLogMessage(" self.Presets  %s \n self.Classes  %s \n self.classIndex  %s \n self.GunIndex %s \n self.Gun  %s \n", self.Presets, self.Classes, self.classIndex, self.GunIndex, self.Gun) end
    return self
end

-- <~~member functions~~>
function NoRecoil:compensateRecoil()
    local x = self.Gun[1] + math.random(-1, 1) -- random horizontal movement on x
    local y = YY + self.Gun[2] + math.random(-1, 1) -- random vertical movement on Y
    local t = TT + self.Gun[3] + math.random(-2, 2) -- random in time between shots on T
    MoveMouseRelative(x, y)
    Sleep(t)
    if logging then OutputLogMessage(" --->  YY:%s TT:%s ---> %s  x:%s y:%s t:%s  \n", YY, TT, self.GunIndex, x, y, t) end
end

-- ~~getters~~
function NoRecoil:currentWeapon()  return self.GunIndex  end
function NoRecoil:currentClass()  return self.classIndex  end
function NoRecoil:scriptState()  return self.noRecoilBool  end

-- ~~setters~~
function NoRecoil:startScript()
    if logging and self.noRecoilBool == false then OutputLogMessage("\n Start \n") end
    self.noRecoilBool = true  end
function NoRecoil:stopScript()
    if logging and self.noRecoilBool == true then OutputLogMessage("\n Finished \n") end
    self.noRecoilBool = false
    self:resetTY()
end

function NoRecoil:addY()  YY = YY + 1  end
function NoRecoil:subY()  YY = YY - 1  end
function NoRecoil:slowerT()  TT = TT + 1  end
function NoRecoil:fasterT()  TT = TT - 1  end
function NoRecoil:resetTY()  TT = 0  YY = 0  end

function NoRecoil:setClass()
        if self.GunIndex == 'Z1100' or self.GunIndex == 'H1100' then g = 5
    elseif self.GunIndex == 'Z0900' or self.GunIndex == 'H0900' then g = 4
    elseif self.GunIndex == 'Z0750' or self.GunIndex == 'H0750' then g = 3
    elseif self.GunIndex == 'Z0650' or self.GunIndex == 'H0650' then g = 2
    elseif self.GunIndex == 'Z0300' or self.GunIndex == 'H0300' then g = 1
    end

        if self.classIndex == 'hip_fire' then c = 2
    elseif self.classIndex == 'zoomed' then c = 1
    end

        if c == 1 then self.classIndex = 'hip_fire'
    elseif c == 2 then self.classIndex = 'zoomed'
    end
    if logging then OutputLogMessage(" ---------------------- Class() --------------------------------------------------------'%s' '%s' '%s' '%s'\n\n ", g, c, self.GunIndex, self.classIndex) end
end

function NoRecoil:setGun()
        if self.GunIndex == 'Z1100' then gz = 5
    elseif self.GunIndex == 'Z0900' then gz = 4
    elseif self.GunIndex == 'Z0750' then gz = 3
    elseif self.GunIndex == 'Z0650' then gz = 2
    elseif self.GunIndex == 'Z0300' then gz = 1
    elseif self.GunIndex == 'H1100' then gh = 5
    elseif self.GunIndex == 'H0900' then gh = 4
    elseif self.GunIndex == 'H0750' then gh = 3
    elseif self.GunIndex == 'H0650' then gh = 2
    elseif self.GunIndex == 'H0300' then gh = 1
    end

        if gz == 4 then self.GunIndex = 'Z1100'
    elseif gz == 3 then self.GunIndex = 'Z0900'
    elseif gz == 2 then self.GunIndex = 'Z0750'
    elseif gz == 1 then self.GunIndex = 'Z0650'
    elseif gz == 5 then self.GunIndex = 'Z0300'
    elseif gh == 4 then self.GunIndex = 'H1100'
    elseif gh == 3 then self.GunIndex = 'H0900'
    elseif gh == 2 then self.GunIndex = 'H0750'
    elseif gh == 1 then self.GunIndex = 'H0650'
    elseif gh == 5 then self.GunIndex = 'H0300'
    end

        if self.GunIndex == 'Z1100' or self.GunIndex == 'H1100' then g = 5
    elseif self.GunIndex == 'Z0900' or self.GunIndex == 'H0900' then g = 4
    elseif self.GunIndex == 'Z0750' or self.GunIndex == 'H0750' then g = 3
    elseif self.GunIndex == 'Z0650' or self.GunIndex == 'H0650' then g = 2
    elseif self.GunIndex == 'Z0300' or self.GunIndex == 'H0300' then g = 1
    end

    self.Gun = self.Classes[self.classIndex][self.GunIndex]
    if logging then OutputLogMessage(" ********************** Gun() *************************************************************************** %s %s \n\n ", g, self.GunIndex) end
end

function NoRecoil:setZoomGun()
        if self.GunIndex == 'Z1100' or self.GunIndex == 'H1100' then g = 5
    elseif self.GunIndex == 'Z0900' or self.GunIndex == 'H0900' then g = 4
    elseif self.GunIndex == 'Z0750' or self.GunIndex == 'H0750' then g = 3
    elseif self.GunIndex == 'Z0650' or self.GunIndex == 'H0650' then g = 2
    elseif self.GunIndex == 'Z0300' or self.GunIndex == 'H0300' then g = 1
    end

        if g == 5 then self.GunIndex = 'Z1100'
    elseif g == 4 then self.GunIndex = 'Z0900'
    elseif g == 3 then self.GunIndex = 'Z0750'
    elseif g == 2 then self.GunIndex = 'Z0650'
    elseif g == 1 then self.GunIndex = 'Z0300'
    end

    self.Gun = self.Classes[self.classIndex][self.GunIndex]
    if logging then OutputLogMessage(" ********************** Endof setZoomGun() *************************************************************************** %s %s \n\n ", g, self.GunIndex) end
end

function NoRecoil:setHipGun()
        if self.GunIndex == 'Z1100' or self.GunIndex == 'H1100' then g = 5
    elseif self.GunIndex == 'Z0900' or self.GunIndex == 'H0900' then g = 4
    elseif self.GunIndex == 'Z0750' or self.GunIndex == 'H0750' then g = 3
    elseif self.GunIndex == 'Z0650' or self.GunIndex == 'H0650' then g = 2
    elseif self.GunIndex == 'Z0300' or self.GunIndex == 'H0300' then g = 1
    end

        if g == 5 then self.GunIndex = 'H1100'
    elseif g == 4 then self.GunIndex = 'H0900'
    elseif g == 3 then self.GunIndex = 'H0750'
    elseif g == 2 then self.GunIndex = 'H0650'
    elseif g == 1 then self.GunIndex = 'H0300'
    end

    self.Gun = self.Classes[self.classIndex][self.GunIndex]
    if logging then OutputLogMessage(" ********************** Endof setHipGun() *************************************************************************** %s %s \n\n ", g, self.GunIndex) end
end

-- ----------------------------------------------------------------~~start of main program~~ ------------------------------------------------------------
EnablePrimaryMouseButtonEvents(true)
local NoRecoilObject = NoRecoil(initial_Class, initial_Weapon, presets, classes)


function OnEvent(event, arg)
    if (IsModifierPressed("lshift") and NoRecoilObject:scriptState() == true) then NoRecoilObject:addY() end
    if (IsModifierPressed("lctrl")  and NoRecoilObject:scriptState() == true) then NoRecoilObject:subY() end

    if (IsModifierPressed("rshift") and NoRecoilObject:scriptState() == true) then NoRecoilObject:slowerT() end
    if (IsModifierPressed("rctrl")  and NoRecoilObject:scriptState() == true) then NoRecoilObject:fasterT() end

    --~~switch weapon~~
    if (event == "MOUSE_BUTTON_PRESSED" and arg == 3) then
        NoRecoilObject:setGun() if logging then OutputLogMessage("[+] You have switched weapons: %s\n", NoRecoilObject:currentWeapon()) end
    end
    --~~press zoom~~
    if (event == "MOUSE_BUTTON_PRESSED" and arg == 2 and NoRecoilObject:scriptState() == true) then
        NoRecoilObject:setClass() NoRecoilObject:setZoomGun() if logging then OutputLogMessage("[+] Zoom Classes: %s\n", NoRecoilObject:currentClass()) end
    end
    --~~release zoom~~
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 2 and NoRecoilObject:scriptState() == true) then
        NoRecoilObject:setClass() NoRecoilObject:setHipGun() if logging then OutputLogMessage("[+] Hip  Classes: %s\n", NoRecoilObject:currentClass()) end
    end
    --~~toggle script~~
    if IsKeyLockOn("CapsLock") then NoRecoilObject:startScript()
    else NoRecoilObject:stopScript() NoRecoilObject:resetTY()
    end
    --~~execute script~~ // Old Script
    if (event == "MOUSE_BUTTON_PRESSED" and arg == 1 and NoRecoilObject:scriptState() == true) then
        repeat
            NoRecoilObject:compensateRecoil()
        until not IsMouseButtonPressed(1) -- orginal
    end
end
