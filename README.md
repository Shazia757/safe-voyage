# Safe Voyage

**Safe Voyage** is a travel and navigation app designed with the safety of women in mind. It offers real-time safety scores, community insights, and secure navigation to ensure safer travel experiences. Built with **Flutter**, this app aims to empower women by providing essential safety information and features for confident solo travel.

## Features

### 1. **Home Page**
   - The main screen of the app displaying quick access to all core features.
   - Search bar to quickly find cities and destinations.
   - Summary of the current location with a safety score and related safety alerts.

### 2. **Safe Routes Page**
   - Helps users find the safest walking routes to their destination.
   - Provides safety score-based route suggestions by analyzing crime data and user feedback.
   - Features an emergency SOS button for instant alerts and calls for help.

### 3. **Destination Safety Page**
   - Displays safety ratings of various cities and destinations.
   - Includes information on local crime rates and risk alerts for each city.
   - Users can view a list of places to travel based on safety scores.

### 4. **Community Page**
   - A platform for women to share their travel experiences, tips, and advice.
   - Includes reviews and ratings from community members regarding destinations and routes.

### 5. **Login and Signup Page**
   - Allows users to create accounts and log in securely to access personalized features.
   - Option for future integration of social logins or more secure authentication.

## Future Features

- **AI Chatbot**: To provide automated safety checks and assistance with common travel concerns.
- **Community Reviews**: A platform where users can add their own travel experiences, reviews, and ratings.
- **Gamification**: Users will earn points for submitting reviews, completing safe trips, and contributing to the community.
- **Firebase Integration**: Future implementation for user authentication, data storage, and backend services.

## Installation

### Prerequisites

To run this project locally, ensure you have the following installed:
- Flutter SDK (version 2.x or above)
- Android Studio (or any Flutter-compatible IDE)
- Dart SDK

### Steps to Run

1. Clone the repository:
   git clone https://github.com/Shazia757/safe-voyage.git

2. Navigate to the project directory:
   cd safe-voyage

3. Install the dependencies:
   flutter pub get

4. Run the app on your preferred device/emulator:
   flutter run

   ### Tech Stack
**Flutter**: Cross-platform app development framework.
**Dart**: Programming language used for building the app.
**GetStorage**: For local storage (used for user preferences and data persistence).
**Geocoding API**: For converting addresses to geographic coordinates.
**OpenStreetMap (OSRM)**: For route mapping and directions.
**Future Integration**: Firebase for backend services, AI for chatbot, etc.