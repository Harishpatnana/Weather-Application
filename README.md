# 🌤️ Weather App - Flutter

A simple yet elegant **Flutter-based mobile application** that fetches **current weather data** for any city using the **OpenWeatherMap API**. This app allows users to input a city name and view the **temperature**, **humidity**, and **weather condition** along with a relevant icon.

---

## 📱 Preview
<p align="center">
  <img src="screenshots/input_screen.png" width="250">
  <img src="screenshots/output_dialog.png" width="250">
</p>

---

## 🔍 Key Features

- 🔎 **City Search** – Enter the name of any city in the world.
- 🌡️ **Live Weather Info** – Real-time temperature, humidity, and condition.
- 🖼️ **Weather Icon** – Displays an official weather icon from OpenWeatherMap.
- 📉 **Error Handling** – Alerts for empty input, invalid cities, or failed API responses.
- 🎯 **Lightweight** – Clean UI and minimal dependencies.
- 🧪 **Ideal for Beginners** – Easy-to-read code and great for learning Flutter basics.

---

## 🧠 Learning Goals

This project helps understand:

- Making HTTP requests in Flutter using `http` package.
- Parsing JSON from RESTful APIs.
- Managing widget state with `setState`.
- Using `TextField`, `ElevatedButton`, `SnackBar`, and `AlertDialog`.
- Dynamically updating UI based on API data.

---

## 🔗 API Used

**[OpenWeatherMap API](https://openweathermap.org/current)**  
- Endpoint: `https://api.openweathermap.org/data/2.5/weather`
- Required Params:
  - `q` = City name
  - `appid` = Your API key
  - `units=metric` (for °C)
- Returns:
  - `main.temp` → Temperature
  - `main.humidity` → Humidity
  - `weather[0].description` → Condition
  - `weather[0].icon` → Icon code

---

## ⚙️ Installation Steps

1. **Clone this repo**
   ```bash
   git clone https://github.com/<your-username>/flutter-weather-app.git
   cd flutter-weather-app
