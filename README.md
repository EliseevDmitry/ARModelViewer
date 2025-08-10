# ARModelViewer

ARModelViewer is a module for integrating 3D models into augmented reality using SwiftUI and ARKit/RealityKit. It supports loading models from resources and files, displays gesture hints, and enables moving, rotating, and scaling 3D objects within the AR environment.

![SwiftUI iOS 18.0](https://img.shields.io/badge/SwiftUI-iOS%2018.0-0366d6?style=flat&logo=swift&logoColor=white)
![MVVM Architecture](https://img.shields.io/badge/-MVVM-0366d6?style=flat&logo=swift&logoColor=white&labelColor=555555)
![async/await](https://img.shields.io/badge/-async%2Fawait-0366d6?style=flat&logo=swift&logoColor=white&labelColor=555555)
![UIKit in SwiftUI](https://img.shields.io/badge/-UIKit%20in%20SwiftUI-0366d6?style=flat&logo=swift&logoColor=white&labelColor=555555)
![ARKit / RealityKit](https://img.shields.io/badge/-ARKit%20%2F%20RealityKit-0366d6?style=flat&logo=apple&logoColor=white&labelColor=555555)
![Combine](https://img.shields.io/badge/-Combine-0366d6?style=flat&logo=apple&logoColor=white&labelColor=555555)
![FileManager](https://img.shields.io/badge/-FileManager-0366d6?style=flat&logo=apple&logoColor=white&labelColor=555555)
![Unit Testing](https://img.shields.io/badge/-Unit%20Testing-0366d6?style=flat&logo=xcode&logoColor=white&labelColor=555555)

---

## About ARModelViewer

ARModelViewer is a specialized module of the commercial application R-gallery — a large group of companies operating in two countries and three cities. The module is designed for interactive fitting of designer 3D staircases in augmented reality.  
The choice of the MVVM architectural pattern based on SwiftUI is driven by the need for rapid and high-quality feature development while maintaining a high level of UX and reliability. Targeting iOS 18+ is a strategic decision aimed at the premium segment of clients with high product expectations.

## Project Description

The module provides users with a convenient and intuitive interface for visualizing and placing 3D models (USDZ) of staircases and other objects in an AR environment.  
- All models can be either bundled locally within the app or uploaded by users from their iPhones via the system file manager.  
- The QuickLookThumbnailing framework is used to render high-quality and fast previews of 3D models.  
- Model import is implemented via `UIDocumentPickerViewController`, integrated into SwiftUI through `UIViewControllerRepresentable` with the use of `@Binding` to pass URLs, ensuring transparent and reactive interaction without the need for closures.  
- Placement of 3D objects in the AR scene is done using RealityKit.  
- Model manipulation is implemented with a set of adapted gestures: Tap, Pinch, Pan, and Rotation. All gestures take into account device orientation and spatial position, providing natural and predictable model behavior regardless of the phone’s position.  
- The starting placement point is implemented via a custom `FocusEntity` that dynamically follows the camera movement, enhancing positioning convenience.  
- To improve user experience, a gesture onboarding feature is implemented — an animated sequence of cards with explanations and SF Symbols icons, which plays once and is managed through state saved in UserDefaults.  
- For ease of testing and extensibility, the UserDefaults service is encapsulated and injected via dependency injection.  
- Asynchronous loading and management of models are built on modern async/await. Legacy callback-based APIs are wrapped using `withUnsafeThrowingContinuation` to ensure a uniform style and code reliability.  
- Event streams for model loading and onboarding display are managed using Combine.  
- All business logic, including services and ViewModels, is covered by unit tests.

## Technologies and Architecture

- **Language:** Swift 5+  
- **Frameworks:** SwiftUI, RealityKit, ARKit, QuickLookThumbnailing, Combine, UIKit (via UIViewControllerRepresentable)  
- **Architecture:** MVVM with Dependency Injection  
- **Asynchrony:** async/await with safe wrappers for legacy APIs  
- **Storage:** UserDefaults through a DI service  
- **Testing:** Unit tests for ViewModels and services  
- **Target:** iOS 18+ — platform choice is dictated by the need to segment the premium client audience, ensuring an effective filter of R-gallery’s paying customers.

## Key Features

- Professional AR interaction: adapted gestures that consider device orientation guarantee natural interaction with 3D models in augmented reality.  
- Premium UX: gesture onboarding with clear visual hints and the ability to disable it, added per Apple Review Team recommendations during app submission.  
- High-quality code: consistent use of async/await, strict typing, modern Swift APIs, and comprehensive module testing.  
- Flexible 3D model handling: supports both built-in models in the app bundle and user-uploaded USDZ models.  
- Clean UIKit integration in SwiftUI: use of UIViewControllerRepresentable with `@Binding` for passing file URLs eliminates the need for closures and simplifies reactive logic.

## Usage

- The module is ready for integration into large commercial projects with high customization demands for AR experience and user interface quality.  
- Intended for apps targeting the premium segment with a modern technology stack.

## Resources and Links

- R-gallery company — [r-gallery.ru](https://r-gallery.ru](https://www.r-gallery.ru/ulica_akademgorodok_kja/))  
(Local 3D staircase model in the app bundle corresponds to the real object on the company website)  
- Additional 3D model example (robot) taken from Apple’s official resource:  
Apple Developer AR Quick Look
