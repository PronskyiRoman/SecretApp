# README

## 🙏 Gratitude  
First of all, I would like to thank the reviewers for taking the time to go through my test assignment. I hope that the project’s structure and architecture will make it easy to navigate the codebase and enjoyable to review.  

## 🚀 About the Project  
- The project is built using **UIKit** and uses **SceneDelegate** as the initial entry point.  
- The architecture is based on **The Composable Architecture (TCA)**, integrated via **Swift Package Manager**.  
  - TCA is wrapped inside the **`ArchitectureTools`** module, which serves as an abstraction layer.  
  - This design allows us to replace TCA with another solution in the future by modifying only a single module, without affecting other parts of the app.  
- Navigation is implemented with **UIKit**, without external dependencies.  
- The codebase follows a **modular architecture**:  
  - `platform-agnostic` modules contain business logic that can be reused across platforms.  
  - `platform-specific` modules provide iOS-specific implementations.  
  - This approach simplifies testing, improves scalability, and ensures a shared business logic across multiple platforms.  
- The project is structured according to **Clean Architecture** principles:  
  - small, isolated components;  
  - highly testable and maintainable objects;  
  - easy to extend with new features.  

## ⚠️ Important for Running the Project  
- On the first build, the project will request **permission to run macros** from the TCA package.  
- This is required — without granting permission, the project will not compile.  
- After allowing macros, please re-run the build.

## 🎬 Demo Features  
- For demonstration purposes, an **action is triggered 3 seconds after app launch** that automatically navigates the user to the **QR code scanning screen**.    

## 📱 Device Shake Event  
- Currently, the **device shake listener** is implemented at the **application level**.  
- This means that shaking the device on **any screen** will trigger a notification, asking the user if they want to navigate to the **QR code scanning screen**.  
- Since handling this event was not explicitly described in the test assignment, this implementation was chosen for demonstration purposes.  
- In a real-world scenario, these requirements would be clarified upfront and implemented strictly according to the feature design.  

## 🧪 Testing  
- At the moment, there are no unit tests due to time limitations.  
- However, thanks to the chosen architecture, adding **unit and UI tests** will be straightforward and fast.  

## ❌ What’s Missing (Due to Time Constraints)  
- iOS **Haptics** implementation.  
- iOS **Device Shake** interaction implementation. 
- Customized **QR code** generator and **QRCodeScanner camera hood**.  

---
