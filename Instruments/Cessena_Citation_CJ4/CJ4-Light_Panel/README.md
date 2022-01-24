## Cessna Citation CJ4 Light Control Panel:
- **v1.0** 
Released 8-2-21
	- Original Panel Created

- **v2.0** 
  Released 10-06-2021-8-2021
	- New custom graphics
	- Backlighting
	- Night mode (when used in conjunction with Simstrumentation Ambient Light Control)
	- Pilot and copilot PFD and MFD dimming in virtual cockpit
	- Pilot-side PFD and MFD dimming will also dim Simstrumentation CJ4 PFD / MFD overlays in Air Manager
	- Master light dimmer will control both instrument backlighting in the virtual cockpit and Simstrumentation CJ4 Air Manager instruments
	- Mobiflight events replaced with H: events and L: variables 
- **v2.1** 01-08-2022  SIMSTRUMENTATION
    - Files capitials renamed for SI Store submittion
    - Fixed panel dimmer knob skipping when turning all the way to left
    - Click and Dial sounds replaced with custom.	
	
## Left To Do:

	
## Notes:
 - The Panel Dimmer (BackLighting) in the cockpit allows you to turn all the way to the left and should set A:Light Potentiometer:3 to a Double value of "0.0" but in the game it remains as "0.10", which is the value before, which i believe is a bug in the SIM. Thus this causes this panel to act strange if you overturn to the left.
 - TCAS is INOP in game. Not used.
 - You may have to push the in-game cockpit buttons twice to turn off a light if you turned it on from AirManager. Not sure if a WT issue or Asbro issue. The "toggle" events do not seem to update tooltips, could probably use LVARS as it does update when using ExtController.
	
	