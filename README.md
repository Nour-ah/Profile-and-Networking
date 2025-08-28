# Flutter Social App (Task Submission)

## 🚀 Tools, Frameworks & Libraries Used
- **Flutter** (UI framework)
- **Dart** (Programming language)
- **Firebase Authentication** (Sign In / Sign Up)
- **Firebase Firestore** (User profiles & data)
- **Firebase Storage** (Profile image upload)
- **Bloc / Cubit** (State Management)
- **Image Picker** (Select images from gallery)
- **Material Design** (UI components with Dark/Light theme)

---

## ⏱️ Time Spent
- Total implementation time: ~ 7 hours  
  (divided across 3 days)

---

## ⚡ Key Challenges & Solutions
1. **Firebase Storage Billing**  
   - Problem: Couldn’t upload profile images because Firebase Storage required upgrading the project to a paid plan (Blaze).  
     

2. **Firebase Rules & Permissions**  
   - Problem: Upload failed due to missing storage rules.  
     

4. **Theme Switching (Dark/Light Mode)**  
   - Problem: Needed a global toggle for theme across the app.  
   - Solution: Implemented `ThemeCubit` with `BlocBuilder` at the root `MaterialApp`, and added a toggle icon in `AppBar` and `LoginScreen`.  

---

## 🔮 Future Scalability
- Add push notifications using **Firebase Cloud Messaging (FCM)**.  
- Optimize images with caching (`cached_network_image`).  
- Add role-based access control (e.g., admin vs user).  
- Support multiple languages with `flutter_localizations`.  
- Improve error handling with custom exception classes.  

---

## 📱 Live Demo & Code
- **APK Download:** [Click here](https://drive.google.com/drive/folders/1qb0r81tpyjyk51AfT4dZIpD7BNub_iWq?hl=ar)  
- **GitHub Repository:** [Click here](https://github.com/Nour-ah/Profile-and-Networking.git)  
