-- Ad the following line into LGhub script:
-- dofile("C:/Users/yourusername/AntiRecoil.lua")
-- This will run the script but give you ability to edit outside of lghub

initial_Class = "hip_fire"
initial_Weapon = "H0650"

local NoRecoil = {}
NoRecoil .__index = NoRecoil
setmetatable(   NoRecoil, {
    __call = function (cls, ...)
        return cls.new(...)
    end,
})


local presets = {
    ["H0300"] = {0,20,200},
    ["Z0300"] = {0,15,200},

    ["H0650"] = {0,12,92},
    ["Z0650"] = {0,9,92},

    ["H0750"] = {0,17,80},
    ["Z0750"] = {0,8,80},

    ["H0900"] = {0,18,66},
    ["Z0900"] = {0,9,66},

    ["H1100"] = {0,12,54},
    ["Z1100"] = {0,9,54},
}

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
--     <~~constructor~~>
function NoRecoil.new(selectedClass, Gun, setPresets, setClasses) OutputLogMessage("\n\n\n\n\n\n ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ NoRecoil.new ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
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
    OutputLogMessage(" self.Presets  %s \n self.Classes  %s \n self.classIndex  %s \n self.GunIndex %s \n self.Gun  %s \n", self.Presets, self.Classes, self.classIndex, self.GunIndex, self.Gun)
    return self
end
--                <~~member functions~~>
function NoRecoil:compensateRecoil() -- Recoil
    local x = self.Gun[1]+math.random(-1,1)
    local y = YY+self.Gun[2]+math.random(-1,1)
    local t = TT+self.Gun[3]+math.random(-2,2)
    MoveMouseRelative(x,y)
    Sleep(t)
    OutputLogMessage(" --->  YY:%s TT:%s ---> %s  x:%s y:%s t:%s  \n", YY, TT, self.GunIndex, x,y,t )
end

--~~getters~~
function NoRecoil:currentWeapon() return self.GunIndex end
function NoRecoil:currentClass()  return self.classIndex end
function NoRecoil:scriptState() return self.noRecoilBool end

--~~setters~~
function NoRecoil:startScript() self.noRecoilBool = true end
function NoRecoil:stopScript() self.noRecoilBool = false end

function NoRecoil:addY() YY = YY + 1 end
function NoRecoil:subY() YY = YY - 1 end
function NoRecoil:slowerT() TT = TT + 1 end
function NoRecoil:fasterT() TT = TT - 1 end
function NoRecoil:resetTY() TT = 0 YY = 0 end

function NoRecoil:setClass()
    if (self.GunIndex == 'Z1100' or self.GunIndex == 'H1100' ) then g = 5 end
    if (self.GunIndex == 'Z0900' or self.GunIndex == 'H0900' ) then g = 4 end
    if (self.GunIndex == 'Z0750' or self.GunIndex == 'H0750' ) then g = 3 end
    if (self.GunIndex == 'Z0650' or self.GunIndex == 'H0650' ) then g = 2 end
    if (self.GunIndex == 'Z0300' or self.GunIndex == 'H0300' ) then g = 1 end
    if self.classIndex == 'hip_fire' then c = 2 end
    if self.classIndex == 'zoomed' then c = 1 end
    if  (c == 1) then self.classIndex = 'hip_fire'  end
    if  (c == 2) then self.classIndex = 'zoomed'  end
    OutputLogMessage(" ---------------------- Class() --------------------------------------------------------'%s' '%s' '%s' '%s'\n\n ", g,c, self.GunIndex,self.classIndex)
end

function NoRecoil:setGun()
    if self.GunIndex == 'Z1100' then gz = 5 end
    if self.GunIndex == 'Z0900' then gz = 4 end
    if self.GunIndex == 'Z0750' then gz = 3 end
    if self.GunIndex == 'Z0650' then gz = 2 end
    if self.GunIndex == 'Z0300' then gz = 1 end
    if self.GunIndex == 'H1100' then gh = 5 end
    if self.GunIndex == 'H0900' then gh = 4 end
    if self.GunIndex == 'H0750' then gh = 3 end
    if self.GunIndex == 'H0650' then gh = 2 end
    if self.GunIndex == 'H0300' then gh = 1 end

    if  gz == 4 then self.GunIndex = 'Z1100' end
    if  gz == 3 then self.GunIndex = 'Z0900' end
    if  gz == 2 then self.GunIndex = 'Z0750' end
    if  gz == 1 then self.GunIndex = 'Z0650' end
    if  gz == 5 then self.GunIndex = 'Z0300' end
    if  gh == 4 then self.GunIndex = 'H1100' end
    if  gh == 3 then self.GunIndex = 'H0900' end
    if  gh == 2 then self.GunIndex = 'H0750' end
    if  gh == 1 then self.GunIndex = 'H0650' end
    if  gh == 5 then self.GunIndex = 'H0300' end

    if (self.GunIndex == 'Z1100' or self.GunIndex == 'H1100' ) then g = 5 end
    if (self.GunIndex == 'Z0900' or self.GunIndex == 'H0900' ) then g = 4 end
    if (self.GunIndex == 'Z0750' or self.GunIndex == 'H0750' ) then g = 3 end
    if (self.GunIndex == 'Z0650' or self.GunIndex == 'H0650' ) then g = 2 end
    if (self.GunIndex == 'Z0300' or self.GunIndex == 'H0300' ) then g = 1 end
    self.Gun = self.Classes[self.classIndex][self.GunIndex]
    OutputLogMessage(" ********************** Gun() *************************************************************************** %s %s \n\n ", g, self.GunIndex)
end

function NoRecoil:setZoomGun()
    if (self.GunIndex == 'Z1100' or self.GunIndex == 'H1100' ) then g = 5 end
    if (self.GunIndex == 'Z0900' or self.GunIndex == 'H0900' ) then g = 4 end
    if (self.GunIndex == 'Z0750' or self.GunIndex == 'H0750' ) then g = 3 end
    if (self.GunIndex == 'Z0650' or self.GunIndex == 'H0650' ) then g = 2 end
    if (self.GunIndex == 'Z0300' or self.GunIndex == 'H0300' ) then g = 1 end
    if  (g == 5) then self.GunIndex = 'Z1100'  end
    if  (g == 4) then self.GunIndex = 'Z0900'  end
    if  (g == 3) then self.GunIndex = 'Z0750'  end
    if  (g == 2) then self.GunIndex = 'Z0650'  end
    if  (g == 1) then self.GunIndex = 'Z0300'  end
    self.Gun = self.Classes[self.classIndex][self.GunIndex]
    OutputLogMessage(" ********************** Endof setZoomGun() *************************************************************************** %s %s \n\n ", g, self.GunIndex)
end

function NoRecoil:setHipGun()
    if (self.GunIndex == 'Z1100' or self.GunIndex == 'H1100' ) then g = 5 end
    if (self.GunIndex == 'Z0900' or self.GunIndex == 'H0900' ) then g = 4 end
    if (self.GunIndex == 'Z0750' or self.GunIndex == 'H0750' ) then g = 3 end
    if (self.GunIndex == 'Z0650' or self.GunIndex == 'H0650' ) then g = 2 end
    if (self.GunIndex == 'Z0300' or self.GunIndex == 'H0300' ) then g = 1 end
    if  (g == 5) then self.GunIndex = 'H1100'  end
    if  (g == 4) then self.GunIndex = 'H0900'  end
    if  (g == 3) then self.GunIndex = 'H0750'  end
    if  (g == 2) then self.GunIndex = 'H0650'  end
    if  (g == 1) then self.GunIndex = 'H0300'  end
    self.Gun = self.Classes[self.classIndex][self.GunIndex]
    OutputLogMessage(" ********************** Endof setHipGun() *************************************************************************** %s %s \n\n ", g, self.GunIndex)
end

-- ----------------------------------------------------------------~~start of main program~~  ------------------------------------------------------------
EnablePrimaryMouseButtonEvents(true)
local NoRecoilObject = NoRecoil(initial_Class,initial_Weapon, presets, classes)

function OnEvent(event, arg)
    if (IsModifierPressed("lshift") and NoRecoilObject:scriptState() == true) then
        NoRecoilObject:addY()
    end
    if (IsModifierPressed("rctrl") and NoRecoilObject:scriptState() == true) then
        NoRecoilObject:fasterT()
    end
    if (IsModifierPressed("lctrl") and NoRecoilObject:scriptState() == true) then
        NoRecoilObject:subY()
    end
    if (IsModifierPressed("rshift") and NoRecoilObject:scriptState() == true) then
        NoRecoilObject:slowerT()
    end

    --~~switch weapon~~
    if (event == "MOUSE_BUTTON_PRESSED" and arg == 3) then
        NoRecoilObject:setGun() OutputLogMessage("[+] You have switched weapons: %s\n", NoRecoilObject:currentWeapon())
    end
    --~~press zoom~~
    if (event == "MOUSE_BUTTON_PRESSED" and arg == 2 and NoRecoilObject:scriptState() == true) then
        NoRecoilObject:setClass() NoRecoilObject:setZoomGun() OutputLogMessage("[+] Zoom Classes: %s\n", NoRecoilObject:currentClass())
    end
    --~~release zoom~~
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 2 and NoRecoilObject:scriptState() == true) then
        NoRecoilObject:setClass() NoRecoilObject:setHipGun() OutputLogMessage("[+] Hip  Classes: %s\n", NoRecoilObject:currentClass())
    end

    --~~toggle script~~
    if IsKeyLockOn("CapsLock")
    then NoRecoilObject:startScript()
    else NoRecoilObject:stopScript() NoRecoilObject:resetTY()
    end
    --~~execute script~~ // Old Script
    if (event == "MOUSE_BUTTON_PRESSED" and arg == 1 and NoRecoilObject:scriptState() == true) then
        repeat
            NoRecoilObject:compensateRecoil()
        until not IsMouseButtonPressed(1) -- orginal
    end
end