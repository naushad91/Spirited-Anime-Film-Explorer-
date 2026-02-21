# 🌿 Spirited — Explore the Ghibliverse

> A modern SwiftUI iOS application built using the Studio Ghibli API.  
> Clean architecture, async/await networking, search with debounce, favourites persistence, and reusable state management.

---

## 📱 About the Project

**Spirited** is a SwiftUI-based iOS app that allows users to:

* Browse Studio Ghibli films
* View detailed film information
* Search films with throttled input
* Mark films as favourites
* Persist favourites locally
* Experience a custom themed UI
* Navigate using a custom tab bar

---

## 📸 Screenshots

### LaunchScreen and MainScreen 
<p align="left">
  <img width="250" alt="Launchscreen" src="https://github.com/user-attachments/assets/d0697637-9ed2-4bf3-b84f-f64ddba00b61" />
  <img width="250" alt="FilmsScreen" src="https://github.com/user-attachments/assets/30d47364-d704-4a34-9a34-2ca77a302496" />
</p>


### DetailViewScreen
<p align="left">  
  <img width="250" alt="DetailScreen1" src="https://github.com/user-attachments/assets/c585190d-d088-44b3-ae36-0af5a954d199" />
  <img width="250" alt="DetailScreen2" src="https://github.com/user-attachments/assets/49857d42-5540-424e-8fdf-6302df79499a" />
</p>

### FavouritesScreen
<p align="left">
  <img width="250" alt="Favourites" src="https://github.com/user-attachments/assets/2460b041-e6bd-4e92-9586-6cdc92816a85" />
  <img width="250" alt="favourites_emptystate" src="https://github.com/user-attachments/assets/c851b272-5258-4067-95e1-9077bfd8db62" />
</p>

### SearchScreen
<p align="left">
  <img width="250" alt="Search" src="https://github.com/user-attachments/assets/3d65d970-3865-4aa7-aabe-12c6a54d795b" />
  <img width="250" alt="Search_emptystate" src="https://github.com/user-attachments/assets/4ef99881-c6bf-4443-a30f-1879c6fc03b6" />
</p>

### SettingsScreen
<p align="left">
  <img width="250" alt="Settings" src="https://github.com/user-attachments/assets/e54613eb-e5b4-4932-9f27-86c5f03c4333" />
</p>

---

## 🛠 Tech Stack

Built with:

* **iOS 17+**
* **SwiftUI**
* **Observation Framework (@Observable)**
* **MVVM Architecture**
* **Protocol-Oriented Service Layer**
* **URLSession + async/await**
* **withTaskGroup (Parallel API Calls)**
* **Generic LoadingState**
* **Swift Testing**
* **UserDefaults for persistence**

---

## 🌐 API Used

**Studio Ghibli API**

* Base URL:
```
https://ghibliapi.vercel.app/
```

* Endpoints used:

```
/films
/people
```

* No authentication required.

---

## 🏗 Architecture

The project follows:

```
View → ViewModel → Service Protocol → Concrete Service
```

### Key Architectural Decisions

* Protocol-based networking layer (`GhibliService`)
* Testable with `MockGhibliService`
* Generic async state handler (`LoadingState<T>`)
* Dependency Injection via initializer
* Separation of UI and business logic
* Reusable components

---

## 📂 Project Structure

```
Spirited
│
├── Favourites
│   ├── FavouriteStorage.swift
│   ├── DefaultFavouriteStorage.swift
│   ├── MockFavouriteStorage.swift
│   └── FavouritesViewModel.swift
│
├── Models
│   ├── Film.swift
│   ├── Person.swift
│   └── Color+Theme.swift
│
├── Networking
│   ├── GhibliService.swift
│   ├── DefaultGhibliService.swift
│   ├── MockGhibliService.swift
│   ├── APIError.swift
│   ├── LoadingState.swift
│   ├── FilmsViewModel.swift
│   ├── FilmDetailViewModel.swift
│   └── SearchFilmsViewModel.swift
│
├── Views
│   ├── LaunchScreen
│   ├── Screen
│   │   ├── FilmsScreen.swift
│   │   ├── FavouritesScreen.swift
│   │   ├── SearchScreen.swift
│   │   ├── SettingsScreen.swift
│   │   └── RootTabContainer.swift
│   ├── FilmRow.swift
│   ├── FilmListView.swift
│   ├── FilmDetailScreen.swift
│   ├── FavouriteButton.swift
│   ├── CustomTabBar.swift
│   └── CustomTabButton.swift
│
└── Tests
```

---

## ✨ Features

### 1️⃣ Film Listing

* Fetches films from `/films`
* Displays list using `List`
* NavigationStack-based navigation
* Async image loading
* Custom row styling

---

### 2️⃣ Film Detail Screen

* Displays:

  * Title
  * Director
  * Release Year
  * Description
  * People associated
* Uses `withTaskGroup` to fetch related data in parallel

```swift
await withTaskGroup(of: Person?.self) { group in
    // Parallel API calls
}
```

✔ Improves performance
✔ Demonstrates structured concurrency

---

### 3️⃣ Search Feature (Debounced)

* `SearchFilmsViewModel`
* Uses `.task(id:)` to debounce input
* Cancels previous search automatically

```swift
.task(id: text) {
    try? await Task.sleep(for: .milliseconds(500))
    guard !Task.isCancelled else { return }
    await searchViewModel.fetch(with: text)
}
```

✔ Prevents unnecessary API calls
✔ Production-style search behavior

---

### 4️⃣ Favourites System

* Uses `Set<String>` to store film IDs
* Stored in `UserDefaults`
* Abstracted via `FavouriteStorage` protocol
* Mockable for testing

```swift
func toggleFavourite(filmID: String)
func isFavourite(filmID: String) -> Bool
```

✔ O(1) lookup using `Set`
✔ Fully testable
✔ Clean separation of storage

---

### 5️⃣ Generic Loading State

Reusable state handler:

```swift
enum LoadingState<T> {
    case idle
    case loading
    case loaded(T)
    case failed(String)
}
```

Used across:

* FilmsViewModel
* SearchFilmsViewModel
* FilmDetailViewModel

✔ Consistent state handling
✔ Cleaner UI switching
✔ Reusable across features

---

### 6️⃣ Custom Tab Bar

* Built from scratch
* Custom center animation
* Separate NavigationStack per tab

---

### 7️⃣ Launch Screen Animation

* Custom SwiftUI animated launch screen
* Center expanding animation

---

## 🧠 Concurrency Concepts Used

* async/await
* Structured Concurrency
* Task cancellation
* withTaskGroup
* Debouncing using Task.sleep
* Async error handling

---

## 🧪 Testing

* Uses **Swift Testing**
* Mock services:

  * `MockGhibliService`
  * `MockFavouriteStorage`
* ViewModels are testable due to protocol injection

---

## 🚀 Future Improvements

* Pagination
* Offline caching
* CoreData support
* Filtering by director/year
* Dark theme variant
* Snapshot UI tests

---



---

## 👨‍💻 Author

**Naushad Khan**

Built as a portfolio-level SwiftUI architecture project.


