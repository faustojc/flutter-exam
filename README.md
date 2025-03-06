# Flutter exam for PDAX

This project is a Flutter application that displays a list of persons fetched from a Faker API. 
It uses the BLoC/Cubit pattern for state management and supports Android, iOS, and Web platforms.

## Getting Started

These instructions will guide you through setting up and running the project on your local machine.

### Prerequisites

-   **Flutter SDK:** Ensure you have the Flutter SDK installed on your machine. If not, follow the official installation guide: [https://docs.flutter.dev/get-started/install](https://docs.flutter.dev/get-started/install)
-   **IDE:** I recommend using Android Studio or VS Code with the Flutter extension for the best development experience.
-   **Android/iOS Emulator or Device (Optional):** If you want to test on a mobile device, have either an emulator/simulator set up or a physical device connected.
-   **Web browser**: For testing on web platform

### Installation

1.  **Clone the Repository:**

    **Using the Terminal/Command Line:**

    ```bash
    git clone https://github.com/faustojc/flutter-exam.git
    ```
    **Using IntelliJ IDEA/Android Studio:**

    -   Open IntelliJ IDEA/Android Studio.
    -   Click on "Get from VCS" from the welcome screen or "File > New > Project from Version Control..." if you have a project open.
    -   Paste the repository URL and click "Clone."

    **Using VS Code:**

    -   Open VS Code.
    -   Click on the "Source Control" icon in the Activity Bar (usually the leftmost icon, looks like a branch).
    -   Click on "Clone Repository."
    -   Paste the repository URL and press Enter.

2. **Navigate to the Project Directory:**

   **Using the Terminal/Command Line:**

    ```bash
    cd flutter_exam
    ```
   **Using IntelliJ IDEA/Android Studio/VS Code:**
    - The IDE automatically does this step after cloning.

3.  **Install Dependencies:**
    Run the command in terminal:

    ```bash
    flutter pub get
    ```
### Running the App

1.  **Choose a Target Device:**

    **Using the Terminal/Command Line:**

    ```bash
    flutter devices
    ```
    Then select the device from the list

    **Using IntelliJ IDEA/Android Studio:**

    -   Click on the device dropdown menu in the **top toolbar**.
    -   Select an available emulator/simulator or physical device, or choose "Chrome" for web.

    **Using VS Code:**

    -   Click on the device dropdown menu in the **bottom status bar**.
    -   Select an available emulator/simulator or physical device, or choose "Chrome" for web.

2.  **Run the App:**

    **Using the Terminal/Command Line:**

    ```bash
    flutter run
    ```
    **Using IntelliJ IDEA/Android Studio:**

    -   Click the green "Run" button in the toolbar (or "Debug" button for debugging).

    **Using VS Code:**

    -   Press F5 (or go to "Run > Start Debugging") or click "Run Without Debugging" if you don't need debugging.
