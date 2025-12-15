# 🌱 Reflections MySpace — iOS Mobile App

*Reflections My Space* is an iOS mobile application built as a **companion experience** to the Reflections web platform.  
The goal of Reflections is to provide a safe, supportive space for self-reflection, emotional check-ins, and personal growth.

This mobile version focuses on the **My Space** feature, designed for private journaling and daily reflection, with future plans to integrate the full ecosystem of the Reflections platform.

This project was developed as a final project for **MAC221 (iOS Development)**.

---

## 🧭 Project Context

The Reflections platform is being developed as a multi-surface experience:

- **Web Platform**: Community-driven features such as forums, shared reflections, and social interaction  
- **Mobile App (this project)**: A personal, private space for journaling and emotional wellness

The iOS app is intentionally designed to complement the website by offering a **calmer, more intimate mobile experience** focused on self-reflection.

---

## ✨ Current Features (My Space)

### 🧠 Mood Tracking
- Emoji-based mood selector
- Selected moods are saved with journal entries
- Mood selection influences AI-generated prompts

### 🤖 AI-Powered Reflection Prompts
- “Need a Nudge?” feature generates gentle journaling prompts
- Prompts adapt based on the user’s selected mood
- Designed to support users when they are unsure what to write

### 📝 Journaling
- Manual journal entries
- Prompt-based reflections
- Tagging system for organization
- Entries are displayed as post-style cards with full content visibility

### 🔥 Streak System
- Tracks consecutive journaling days
- Encourages consistency without pressure
- Displays current and longest streaks

### 😊 Smile Carousel
- Users can upload personal photos that bring joy
- Images rotate automatically as a slideshow
- Helps create a positive emotional environment

### 💾 Local Persistence
- Journal entries, moods, photos, and streaks are stored locally using `UserDefaults`

---

## 🧠 Architecture & Tech Stack

- **SwiftUI**
- **MVVM (Model–View–ViewModel) architecture**
- Modular project structure:
  - `Models`
  - `ViewModels`
  - `Views`
  - `Services`
  - `Utils`

---

## 🤖 AI Integration

This app integrates with the **OpenAI API** to generate supportive, non-judgmental journaling prompts.

- API keys are **not included** in this repository
- Keys are managed securely and excluded via `.gitignore`
- The app functions without AI features unless a valid key is provided

---

## 🔐 API Key Setup (Optional)

To enable AI prompts:

1. Create a private configuration file (not tracked by Git)
2. Add your OpenAI API key:

```
OPENAI_API_KEY=your_key_here
```

3. Ensure the file is listed in `.gitignore`

---

## 📱 Requirements

- iOS 17+
- Xcode 15+
- Swift 5.9+

---

## 🚀 How to Run

1. Clone the repository
2. Open `reflections.xcodeproj` in Xcode
3. Select an iOS Simulator or physical device
4. Build and run

---

## 🔮 Future Improvements

Planned enhancements include:

### Mobile App
- Entry editing and search
- Mood analytics and insights
- iCloud sync
- Notification reminders
- Accessibility enhancements

### Platform-Wide (Web + Mobile)
- Community forums
- Social interaction and shared reflections
- Parent-focused discussion spaces
- User profiles and personalization
- Moderation and safety tools

These features are already part of the broader Reflections platform vision and will be incrementally integrated into the mobile experience.

---

## 👩‍💻 Author

**Blanca Altamirano**  
AAS Programming & Software Development  
LaGuardia Community College  

---

## 📜 License

This project is for educational purposes only.

