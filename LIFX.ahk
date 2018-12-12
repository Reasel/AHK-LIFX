class LIFXLight
{
	Token   := ""
	
	; Unique ID for the light
	ID := ""
	
	; Name of the Light
	Name := ""
	
	; Naem of the group its in
	GroupName := ""
	
	; What GroupID 
	GroupID := ""
	
	; Builds a new Light based on the name of the light. Pings the API to get info on the given light name and then parses the JSON result for the information.
	__New(name)
	{
		info := this.LightInfo(name)
		this.ID := json(info, "id")
		this.Name := json(info, "label")
		this.GroupName := json(info, "group.name")
		this.GroupID := json(info, "group.id")
		return this
	}
	
	; Does a HTTP request with the given type and using the given URL with given body. Returns the resulting JSON object if any
	DoRequest(type, URL, Req_Body="")
	{
		WinHTTP := ComObjCreate("WinHTTP.WinHttpRequest.5.1")
		WinHTTP.SetProxy(0)
		WinHTTP.Open(type, URL, 0)
		WinHTTP.SetRequestHeader("Authorization", "Bearer " this.Token)
		WinHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
		WinHTTP.Send(Req_Body)
		
		Result := WinHTTP.ResponseText
		; Status := WinHTTP.Status
		return Result
	}
	
	; Sets this light to the settings contained in the given body.
	SetLightByBody(Req_Body)
	{
		return this.DoRequest("PUT", "https://api.lifx.com/v1/lights/id:" this.ID "/state", Req_Body)
	}
	
	; Toggles this light from on to off an vice versa
	Toggle()
	{
		return this.DoRequest("POST", "https://api.lifx.com/v1/lights/id:" this.ID "/toggle")
	}
	
	; Activate the pulse effect on this light
	; inColor           -> The color to start with 
	; fromColor      -> The color to change to
	; period            -> How long it takes in seconds to transition to the next color
	; cycles             -> How many times to transition
	; persist            -> Determines whether to return to the color this light was set to before the pulse effect at the end of pulsing
	; power_on       -> Determines if the light should be powered on before pulsing
	Pulse(inColor, fromColor, period, cycles, persist="false", power_on="false")
	{
		return this.DoRequest("POST", "https://api.lifx.com/v1/lights/id:" this.ID "/effects/pulse", "color=" inColor "&from_color=" fromColor "&period=" period "&cycles=" cycles "&persist=" persist "&power_on=" power_on)
	}
	
	; Set this lights color to the newValue
	SetColor(newValue)
	{
		return this.SetLightByBody("color=" newValue)
	}
	
	; Set this lights brightness to the newValue
	SetBrightness(newValue)
	{
		return this.SetLightByBody("brightness=" newValue)
	}
	
	; Set this lights power to the newValue
	SetPower(newValue)
	{
		return this.SetLightByBody("power=" newValue)
	}
	
	; Set this lights infrared to the newValue
	SetInfrared(newValue)
	{
		return this.SetLightByBody("infrared=" newValue)
	}
	
	; Gets and returns a list of all scenes available to be called by the token. Returned objects is a JSON object.
	GetScenes()
	{
		return this.DoRequest("GET", "https://api.lifx.com/v1/scenes")
	}
	
	; Gets and returns a list of lights available to be called by the token. Returned objects is a JSON object.
	GetLights()
	{
		return this.DoRequest("GET", "https://api.lifx.com/v1/lights/all")
	}
	
	; Gets and returns this lights status in JSON form
	LightStatus()
	{
		return this.DoRequest("GET", "https://api.lifx.com/v1/lights/id:" this.ID)
	}
	
	; Gets and returns the status of light by name in JSON form
	LightInfo(name)
	{
		return this.DoRequest("GET", "https://api.lifx.com/v1/lights/label:" name)
	}
	
	; Activates a scene by name with optional fast setting and duration setting. Defaults to fast and duration of 0.1. This is for Very fast scene changes.
	ActivateScene(scene, fast="true", duration="0.1")
	{
		return this.DoRequest("PUT", "https://api.lifx.com/v1/scenes/scene_id:" scene "/activate", "fast=" fast "&duration=" duration)
	}
	
	Police()
	{
		this.Pulse("red", "blue", "0.5", "20", "false", "true")
	}
}

json(js, s) 
{
	j = %js%
	Loop, Parse, s, .
	{
		p = 2
		RegExMatch(A_LoopField, "([+\-]?)([^[]+)(?:\[(\d+)\])?", q), q3 := q3 ? q3 : 0
		Loop
		{
			If (!p := RegExMatch(j, "(""|')([^\1]+?)\1\s*:\s*((""|')?[^\4]*?\4|(\{(?:[^{}]*+|(?5))*\})|[+\-]?\d+(?:\.\d*)?|true|false|null?)\s*(?:,|$|\})", x, p))
			{
				Return
			}
			Else If (-1 == q3 -= x2 == q2 or q2 == "*") 
			{
				j = %x3%
				z += p + StrLen(x2) - 2
				Break
			}
			Else 
			{
				p += StrLen(x)
			}
		}
	}
	Return, SubStr((x3 == "false" ? 0 : x3 == "true" ? 1 : x3 == "null" or x3 == "nul" ? "" : SubStr(x3, 1, 1) == "" ? SubStr(x3, 2, -1) : x3), 2, (StrLen(GenID) - 1))
}
