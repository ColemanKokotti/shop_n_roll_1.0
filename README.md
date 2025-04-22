# shop_n_roll

An advanced Flutter app for managing your grocery shopping list, with user authentication and customization via Firebase.

## Main Features

- **Firebase Authentication**
  - Login with email/username and password
  - Register a new account
  - Automatic login if you don't log out
  - Logout and secure session management
- **Advanced Error Handling**
  - Specific error messages for failed login, non-existent account, incorrect credentials, etc.
  - Error dialogs localized in multiple languages
- **User Profile Management**
  - Edit username, email, and avatar
  - Display custom user avatar
  - Delete account with confirmation and feedback
- **Shopping List Management**
  - Quickly add items via floating action button
  - Swipe to delete with confirmation and undo (restore)
  - Specify quantity for each item
  - Status icon (purchased/not purchased)
  - Customize product icon
  - Bottom total price bar
- **Personalization & Accessibility**
  - Theme switching (light/dark/default)
  - Language switching (multi-language support: EN, IT, FR, ES, DE, JA, RU, RO, HI, ZH, AR)
  - Full localization of all strings and dialogs
- **Realtime Sync & Security**
  - Real-time sync with Firebase Firestore
  - Secure credential management

## Completed Features
- Floating Add Button:
  - A floating action button that lets users quickly add items to the list.
- Swipe to Delete with Confirmation:
  - Swipe left to delete an item with confirmation and removal from Firebase.
- Theme Management:
  - A settings button at the top allows users to change the app theme.
- Icon Customization:
  - Tap the item icon to modify it.
- Undo Button:
  - When an item is deleted, an "Undo" button appears at the bottom and stays visible for 10 seconds before disappearing.
- Quantity Management:
  - Ability to specify quantities for each item in the list.
- Item Status Icon:
  - An icon that indicates whether a product is still to be purchased or has already been bought.
  - When the item is marked as purchased, the icon updates to reflect this status change.

## Upcoming Features
- Guest Mode: quick access without registration
- Image upload for products from the gallery
- Detailed item view with images
- Ability to link a guest account to a real account
- Improved push notifications

## Installation
To get started with the project:

### Clone the repository:
    git clone https://github.com/ColemanKokotti/shop_n_roll_1.0.git
    Install dependencies: flutter pub get
    Run the app: flutter run

### Firebase Integration
The app uses Firebase for authentication and data storage.
- Create a Firebase project from the Firebase Console.
- Follow the instructions to integrate Firebase with Flutter.
- Add your configuration in `firebaseConfig.dart`.

### Contributing
1. Fork the repository
2. Create a branch for your feature (git checkout -b feature-name)
3. Commit your changes (git commit -am 'Add new feature')
4. Push to the branch (git push origin feature-name)
5. Open a pull request

### License
This project is licensed under the MIT License - see LICENSE.md for details.