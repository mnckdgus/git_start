CapsLock::
KeyDown(A_ThisHotkey, "Ctrl")
return

Ctrl::
SetCapsLockState, % GetKeyState("CapsLock", "T") = 1 ? "Off" : "On"
return

KeyDown(oldKey, newKey)
{
   Send, {%newKey% down}
   Loop
   {
      if (GetKeyState(oldKey, "P") = 0)
         break
   }
   Send, {%newKey% up}
   return
}