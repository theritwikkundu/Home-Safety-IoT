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