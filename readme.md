<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Thanks again! Now go create something AMAZING! :D
***
***
***
*** To avoid retyping too much info. Do a search and replace for the following:
*** Simstrumentation, Air-Manager, twitter_handle, email, Air-Manager-Instruments, project_description
-->



<!-- PROJECT SHIELDS
https://user-images.githubusercontent.com/75218511/133441816-29e1ce1e-b461-4a14-ae63-19b5796f72ed.png
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links

  <a href="https://github.com/Simstrumentation/Air-Manager">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>



[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
-->




<!-- PROJECT LOGO -->
<h1 align="center">SIMSTRUMENTATION</h1>
<h2 align="center">EXTERMINATE THE MICE FROM YOUR COCKPIT!</h2>  
<h3 align="center">Flying Microsoft Flight Simulator Mouse-Free using touch screen instruments built on Air Manager</h3>
  

<p align="center">The goal of Air Manager, and subsequently, this collection of instruments, is to be able to offer flight simmers a more realistic mouse and keyboard-free experience for our favourite aircraft. Through the use of touch screens and the optional <a href="https://www.siminnovations.com/hardware/product/57-knobster">Knobster</a> from Sim Innovations, you can have a fully interactive cockpit without requiring the use of a mouse in flight.</p>
<H6>While the download and use of our instruments is free, Air Manager is paid software available at https://www.siminnovations.com/. We are not associated with Sim Innovations in any way and cannot provide users with Air Manager nor can we provide any technical support for Air Manager.</h6>


<!-- TABLE OF CONTENTS 
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>

  </ol>
</details>

-->

<!-- ABOUT THE PROJECT -->
## Aircraft Instrument Categories
<p>This is a list of the different aircraft in MSFS 2020 that we currently have working instruments for.</p>
<h6>At the current time, we don't provide complete panel layouts, just individual instruments. Each person will have a different setup with a different number of monitors in different sizes. Preset panels that work for us won't necessarily work for you. You can use the instruments provided to build a layout that works for you.</h6>

Aircraft <br> (click to view instruments for this plane) |  Plane image
--------|-------------
[Beechcraft Bonanza G36](https://github.com/Simstrumentation/Air-Manager/tree/main/Instruments/Bonanza)| <img src="https://user-images.githubusercontent.com/75218511/133450330-9ba0b3b8-0130-4f72-8687-c1b635c61387.png" width="300">
[Cessena 152](https://github.com/Simstrumentation/Air-Manager/tree/main/Instruments/Cessna_152)| <img src="https://user-images.githubusercontent.com/75218511/133449735-ae8a2cda-b5f7-44d0-aa5c-ba548a50bdd0.png" width="300">
[Cessena 172](https://github.com/Simstrumentation/Air-Manager/tree/main/Instruments/Cessna_C172/) <br /> includes both G1000 and steam gauge variants| <img src="https://user-images.githubusercontent.com/75218511/133437329-3312c807-dbbf-4a73-b99e-e09678afdc82.png" width="300">
[Cessena Citation CJ4](https://github.com/Simstrumentation/Air-Manager/tree/main/Instruments/Cessena_Citation_CJ4/) | <img src="https://user-images.githubusercontent.com/75218511/133437045-c895881c-5502-4885-94dd-b4fe9b288246.png" alt="drawing" width="300"/></p>
[Generic Instruments](https://github.com/Simstrumentation/Air-Manager/tree/main/Instruments/Generic/) | This section contains generic instruments and controls that can be used in a wide variety of aircraft and aren't aircraft-specific. 
[Mooney M20R Ovation (Carenado)](https://github.com/Simstrumentation/Air-Manager/tree/main/Instruments/Mooney_M20R/) | <img src="https://user-images.githubusercontent.com/75218511/133450810-00e7ae37-2f84-47d4-9b09-e3c3af8996bc.png" width="300"/></p>
[TBM 930](https://github.com/Simstrumentation/Air-Manager/tree/main/Instruments/TBM_930/) | <img src="https://user-images.githubusercontent.com/75218511/133437825-439d90a5-4129-45f0-a48d-a30ea18aefad.png" width="300">

## Examples of Air Manager Panel Layouts

Aircraft |  Preview
--------|-------------
Cessna Citation CJ4 |<img src="https://user-images.githubusercontent.com/75218511/133439412-05aea04e-1dac-409f-9335-7844819230b4.png" width=500>
Cessna 172 G1000 |<img src="https://user-images.githubusercontent.com/75218511/133439856-9c2d3323-5f0a-4b6c-8800-071a47859b9e.png" width=500 >
Cessna 172 Classic |<img src="https://user-images.githubusercontent.com/75218511/133449154-3d8774a5-0902-4b73-9737-18ad816e06e9.png" width=500>
Piper Arrow III (Just Flight) |<img src="https://user-images.githubusercontent.com/75218511/133440178-deecb726-7b5e-49b6-8c64-2e0e40262e47.png" width=500>
Beechcraft Baron |<img src="https://user-images.githubusercontent.com/75218511/133440350-5b83c3b4-09d2-4dde-8d71-d933c7c21345.png" width=500>
Mooney M20R - modern cockpit layout with dual G5 and GTN750 |<img src="https://user-images.githubusercontent.com/75218511/133441816-29e1ce1e-b461-4a14-ae63-19b5796f72ed.png" width=500>



<!-- USAGE EXAMPLES -->
## Usage

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

_For more examples, please refer to the [Documentation](https://example.com)_



<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/Simstrumentation/Air-Manager/issues) for a list of proposed features (and known issues).



<!-- CONTRIBUTING -->
## Contributing

Panel Names should not have spaces.
When Export out of AirManger remove the "-" that AirManager Exporter puts in between the Plane Name and Model. 



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Simstrumentation/Air-Manager.svg?style=for-the-badge
[contributors-url]: https://github.com/Simstrumentation/Air-Manager/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Simstrumentation/Air-Manager.svg?style=for-the-badge
[forks-url]: https://github.com/Simstrumentation/Air-Manager/network/members
[stars-shield]: https://img.shields.io/github/stars/Simstrumentation/Air-Manager.svg?style=for-the-badge
[stars-url]: https://github.com/Simstrumentation/Air-Manager/stargazers
[issues-shield]: https://img.shields.io/github/issues/Simstrumentation/Air-Manager.svg?style=for-the-badge
[issues-url]: https://github.com/Simstrumentation/Air-Manager/issues
[license-shield]: https://img.shields.io/github/license/Simstrumentation/Air-Manager.svg?style=for-the-badge
[license-url]: https://github.com/Simstrumentation/Air-Manager/blob/master/LICENSE.txt

