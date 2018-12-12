#Include LIFX.ahk

MyLight := new LIFXLight("Ragnar") ; Given the name of your light you want to control.

; IMPORTANT NOTE
; All functions return the output from the API calls. If you want to see the information then simply print the result.

; You can set the power of your light with SetPower
MyLight.SetPower("off")
MsgBox, Your light is now off!`nPress OK to move to next example.

; You can toggle the light on and off by calling Toggle
MyLight.Toggle()
MsgBox, Your light was toggled from off to on!`nPress OK to move to next example.

; You can set the color by calling SetColor
MyLight.SetColor("blue") ; Sets the light to blue. Also accepts hex colors.
MsgBox, Your light is blue!`nPress OK to move to next example.

; You can control the brightness by calling SetBrightness
MyLight.SetBrightness("0.5") ; Sets the light to brightness 0.5 aka 50%
; You can also input brightness as integer and decimal. It will be sent as a string in the end.
MsgBox, Your light is now set to half brightness!`nPress OK to move to next example.

MyLight.SetBrightness("1.0")
MsgBox, Your light is now set to full brightness!`nPress OK to move to next example.

; You can set the infrared levels of your light if your light supports that.
MyLight.SetInfrared("1.0") ; Sets the infrared of the light to 1.0 aka 100%
; Will do nothing if Light doesn't support infrared.
MsgBox, Your ligh's infrared is now maxxed if it can handle it!`nPress OK to move to next example.

; You can call basic Pulse effects as well
; You send what two colors to alternate between, how fast in seconds to alternate, how many times to alternate, whether to return to original color after completion, and whether to power on before pulsing.
MyLight.Pulse("red", "blue", "0.5", "20", "false", "true")
MsgBox, Your lights are now pulsing from red to blue!`nPress OK to move to next example.

; You can see a list of scenes that your API token can call 
MsgBox, MyLight.GetScences()

; Similarly you can get the status of your light by calling LightStatus
MsgBox, MyLight.LightStatus()

; You can also see all the lights and their statuses by calling getLights
MsgBox, MyLights.GetLights()

MsgBox, That concludes the demo.