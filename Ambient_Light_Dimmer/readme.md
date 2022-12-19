<img align="center" width="100%" src="https://user-images.githubusercontent.com/75218511/147607402-14a0a969-5e23-4b55-b15e-27684508b0ef.png">
<h1 align="center">SIMSTRUMENTATION
</h1><h2 align="center">AMBIENT LIGHT DIMMER (ALD)
</h2>
<p align="center">
<p align="center">
<img src="https://github.com/Simstrumentation/Air-Manager/blob/main/Ambient_Light_Dimmer/f8f83fd0-af45-4991-38cc-4eabc21e872d/preview.PNG?raw=true" width="100">

[Download Ambient Light Dimmer Latest Version v2.2  12-18-2022](https://github.com/Simstrumentation/Air-Manager/blob/main/Ambient_Light_Dimmer/Generic-Ambient_Light_Dimmer.siff?raw=true)</h4>


The ALD talks to the other Air Manager panels and dims the panels according to the dial, by pressing day or night and now evaluates the ambient light value based on time of day and more!

As the sky light dims you're panels now dim automatically.

It's also now possible to dim Philips Hue Lights through an arudino! Have your entire room, or backlight monitor dim just as your instruments dim according to the Sim's environmental conditions. [Click here for Information](https://github.com/Simstrumentation/Air-Manager/tree/main/Ambient_Light_Dimmer/Philips_Hue_Light_Dimming)
</p>


</p>
<h3 align="center">Aircraft Panels Currently Supporting the ALD</h3>

| Aircraft Collection | Image |
| -------------------------------------------------- | ----------- |
| [Cessna Citation CJ4 Collection](https://github.com/Simstrumentation/Air-Manager/tree/main/Instruments/Cessena_Citation_CJ4) | <p align="center"><img src="https://user-images.githubusercontent.com/75218511/136465263-c3e724ac-3730-4831-a9c2-02689306c5c7.png" width ="300"></p><p align="center"><img src="https://user-images.githubusercontent.com/75218511/136465299-82c56770-944d-4117-93f5-d3d44226ba43.png" width ="300"></p>
| [Bombardier CRJ (Aerosoft)Collection](https://github.com/Simstrumentation/Air-Manager/tree/main/Instruments/Bombardier_CRJ) | <p align="center"><img src="https://user-images.githubusercontent.com/38576265/153980237-9595da57-864a-4816-b289-7c6e44db409a.png" width ="300"></p><p align="center"></p>

## Release Notes
- **v1.0** 9-18-21 Rob "FlightLevelRob" Verdon and Joe "Crunchmeister" Gilker
    - Original Panel Created
- **v1.2** 10-1-21 Todd "Toddimus831" Lorey
    - Adjust illumination depending upon sun position
--*********END OF INTERNAL ALPHA TESTING****************
- **v2.0** 10-5-21 Rob "FlightLevelRob" Verdon and Joe "Crunchmeister" Gilker and Todd "Toddimus831" Lorey
    !!- Initial Public Release -!!
    - Variable renaming for clarity
    - Added backlight logic to account for battery, external power and bus volts status
- **v2.01** 10-10-21 SIMSTRUMENTATION
    - Clean up code and add more commenting for sumbission to AM store   
- **v2.1** 01-17-22 SIMSTRUMENTATION
    - Changed to "Generic" aircraft and  New ID (If you have old version this does not over write existing Ambient Light Dimmer)
    - Added User Prop option to select Aircraft. Currently CJ4 and CRJ are available.
    - Seperated variable subscribes for backlighting and power into each aircraft.
    - Made it so the User Prop Hide option hides the background as well
    - Added Philips Hue Light Option (See https://github.com/simstrumentation)
    - Resource folder file capitials renamed for SI Store submittion  
    - Click and Dial sounds replaced with custom.
- **v2.2** 12-18-22 SIMSTRUMENTATION
    - Updated code to reflect AAU1 being released in 2023Q1     
    - Remove Longitude option   
    - Added CRJ backlighting options: Overhead,Pedestal,SidePanel