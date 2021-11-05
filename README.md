# AHK-LIFX
This is a class for handling LIFX lights in AHK.

# Setup
Simply insert your API token from https://cloud.lifx.com/settings into the Token variable on line 3 and you are good to use the library for your own lights. For an example connecting you can use the example script. You will need to edit and replace the name of the light on Line 4 in order for the example script to work.

## Functions


### Basic new
Takes in a name for a light. Using the name it gets the ID, Group Name, and Group ID in order to build the LIFXLight object.
Returns a LIFXLight object.

### Toggle
Takes in nothing and simples toggles the lights power state.
Off -> On
On  -> Off

### Pulse
Activate the pulse effect on this light.
Takes in:
inColor    -> The color to start with 
fromColor  -> The color to change to
period     -> How long it takes in seconds to transition to the next color
cycles     -> How many times to transition
persist    -> Determines whether to return to the color this light was set to before the pulse effect at the end of pulsing
power_on   -> Determines if the light should be powered on before pulsing

### SetColor
Takes in a color or hex number and sets the lights color to the given color if possible.

### SetBrightness
Takes in a number and sets the lights brightness to that value if possible.

### SetPower
Takes in a variable (Should be "on" or "off") and sets the power of the light to it if possible.

### SetInfrared
Takes in a variable and sets the infrared of the light to it if possible.

### GetScenes
Takes in nothing and returns a list of all the scenes returned from the LIFX API that the current token has access to.
This is simply calling list-scenes as seen here: https://api.developer.lifx.com/docs/list-scenes

### GetLights
Takes in nothing and returns a list of all the lights returned from the LIFX API that the current token has access to.
This is simply calling the list-lights as seen here: https://api.developer.lifx.com/docs/list-lights

### LightStatus
Takes nothing and returns the status for only this light.
See GetLights for more information.

### LightInfo
Takes a name as input and returns the status of the light bound with the given name.

### ActivateScene
Takes a name of a scene and optional arguments fast and duration.
Will activate the given scene by name and optionally with do so fast and over a specified duration.
