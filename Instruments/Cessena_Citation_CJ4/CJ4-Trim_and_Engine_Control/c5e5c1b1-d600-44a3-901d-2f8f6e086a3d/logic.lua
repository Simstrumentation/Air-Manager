--[[
******************************************************************************************
******************Cessna Citation CJ4 Trim and Engine Control Panel*******************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: http://simstrumentation.com


- **v1.0** 03-13-2021 Rob "FlightLevelRob" Verdon
    - Original Panel Created
- **v1.1** 08-02-2021 Joe "Crunchmeister" Gilker
   - Fixed start functionality that had been broken by a previous update  
- **v2.0** 09-17-2021 Joe "Crunchmeister" Gilker and Todd "Toddimus831" Lorey
   - New custom graphics
   - Functional covers added to run buttons. Touch or click the cover hinges to open and close.
              Run switches will be INOP until covers are open.
   - Slight tweaks to PIC_EngineX_ and PIC_StarterX positions to center them better in their buttons
   - Refactored code to adapt to native A: variable and K: events and remove MobiFlight dependency
--*********END OF INTERNAL ALPHA TESTING****************
- **v2.0** 10-5-2021 Rob "FlightLevelRob" Verdon and Joe "Crunchmeister" Gilker and Todd "Toddimus831" Lorey
    !!- Initial Public Release -!!
    - Variable renaming for clarity
    - Added backlight logic to account for battery, external power and bus volts status
- **v2.1** 01-16-2022
    - Sounds replaced with custom.
    - Resource folder file capitials renamed for SI Store submittion  
- **v2.2** 12-06-2022 Joe "Crunchmeister" Gilker       
   - Updated code to reflect AAU1 being released in 2023Q1
   
## Left To Do:
  - Secondary Elev Trim is inop.

## Notes:
  - Protective covers on RUN buttons functional. Touch or click the cover hinges to open and close. Run switches will be INOP until covers are open.

******************************************************************************************
--]]
  
--Backgroud Image before anything else
img_add_fullscreen("background.png")
img_bg_night = img_add_fullscreen("bg_night.png")

img_labels_backlight = img_add_fullscreen("labels_backlight.png