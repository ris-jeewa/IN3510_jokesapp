## Joke App - README

### Overview

The **Joke App** is a Flutter-based application that fetches and displays jokes from the [JokeAPI](https://jokeapi.dev/). It allows users to select a joke category and view a list of jokes in a user-friendly interface.

![](E:\L3S1\wireless communication\Screenshot_20241201_223629.png)

### Features

- Fetches jokes from a remote API.
- Supports multiple joke categories such as Programming, Misc, Dark, and Pun.
- Interactive UI with a category dropdown and a "Get Jokes" button.
- Displays fetched jokes in a scrollable list.
- Handles errors and displays fallback messages when jokes cannot be loaded.

---

### Getting Started

#### Prerequisites

- Flutter SDK installed. [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
- Dart SDK (included with Flutter).
- Internet connection for API calls.

#### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/joke-app.git
   cd joke-app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

---

### File Structure

- **`main.dart`**: Entry point of the application. Contains UI logic and interaction.
- **`joke_service.dart`**: Service layer for API interaction. Handles fetching jokes from the JokeAPI.

---

### Code Details

#### main.dart

The main file contains the following:

- **`MyApp`**: The root widget of the application.
- **`MyHomePage`**: A stateful widget managing the main screen of the app, including:
    - Dropdown for selecting joke categories.
    - Button for triggering the fetching of jokes.
    - A scrollable list to display jokes.
    - Loading indicator for API calls.

#### joke_service.dart

The service file contains:

- **`JokeService`**: A class responsible for:
    - Defining joke categories.
    - Fetching jokes from the JokeAPI using the Dio package.
    - Validating categories and error handling.

---

### API Usage

- **Base URL**: `https://v2.jokeapi.dev/joke`
- **Query Parameters**:
    - `amount`: Number of jokes to fetch (default: 5).
    - `type`: Joke type (`single` for single-line jokes).
    - `blacklistFlags`: Filters for inappropriate content.

Example URL:  
`https://v2.jokeapi.dev/joke/Programming?amount=5&type=single&blacklistFlags=nsfw,religious,political,racist,sexist,explicit`

---

### Dependencies

- **Flutter**: Framework for building UI.
- **Dio**: HTTP client for API requests.
  ```yaml
  dependencies:
    dio: ^5.0.0
  ```

---

### Screenshots

1. **Main Screen**: Dropdown for categories and a button to fetch jokes.
2. **Joke List**: Scrollable list displaying fetched jokes.

---

### How to Use

1. Select a category from the dropdown menu.
2. Click the "Get Jokes" button to fetch jokes.
3. View the fetched jokes in the list below.

---

### Error Handling

- Displays a "Failed to load jokes!" message when the API request fails.
- Shows "No Jokes!" when no jokes are available for the selected category.

---

### License

This project is licensed under the MIT License. You are free to use, modify, and distribute it.

---

Enjoy using the Joke App! 😊