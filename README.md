<div id="top"></div>

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

---

<h1 align="center">Home Safety App</h1>

_The primary idea behind this project is to enable users to have a low-cost home safety system with multiple sensors to ensure proper functioning and a robust frontend application to complement the same. The two components will be connected by a secure MQTT server._

---

<br>

> The main objective of this project is to create a comprehensive real-time system for home safety that detects unauthorized intrusion and notifies the user through a mobile app over the internet.

<br>

When logged in, the user can connect to the MQTT channel associated with his username in the backend. Once connected, the widget will change from green to red whenever some motion is detected by the hardware connected to the same MQTT channel and vice versa.

---

<br>

- The frontend of the project is built using `Flutter` to deliver a mobile application for Android which provides user registration and login functionality. `Firebase` realtime database has been used for storage and retrieval of data.

- The prototype is built using `NodeMCU` and `Microwave radar` sensor. The sketch has been written using Arduino IDE.

- The communication has been established using MQTT protocol over `HiveMQ` MQTT broker.

---

<br>

## Developer 👤

<p>
	<a href = 'https://github.com/theritwikkundu' target='_blank'> <img src=https://github.com/edent/SuperTinyIcons/blob/master/images/svg/github.svg height='40px' /></a>
    &nbsp;
<p>

---

Please ⭐️ this repository if this project helped you!


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/theritwikkundu/Home-Safety-IoT.svg?style=for-the-badge
[contributors-url]: https://github.com/theritwikkundu/Home-Safety-IoT/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/theritwikkundu/Home-Safety-IoT.svg?style=for-the-badge
[forks-url]: https://github.com/theritwikkundu/Home-Safety-IoT/network/members
[stars-shield]: https://img.shields.io/github/stars/theritwikkundu/Home-Safety-IoT.svg?style=for-the-badge
[stars-url]: https://github.com/theritwikkundu/Home-Safety-IoT/stargazers
[issues-shield]: https://img.shields.io/github/issues/theritwikkundu/Home-Safety-IoT.svg?style=for-the-badge
[issues-url]: https://github.com/theritwikkundu/Home-Safety-IoT/issues
[license-shield]: https://img.shields.io/github/license/theritwikkundu/Home-Safety-IoT.svg?style=for-the-badge
[license-url]: https://github.com/theritwikkundu/Home-Safety-IoT/blob/master/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/theritwikkundu/