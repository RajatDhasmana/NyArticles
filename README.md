# NyArticles

#  Architecture Used -> MVVM-C

This project demonstrates the implementation of the **MVVM (Model-View-ViewModel-Coordinator)** architecture in a Swift application. The project is structured to showcase clean, modular, and testable code using the MVVM design pattern.

## Table of Contents

- [Introduction](#introduction)
- [Technologies Used](#technologies-used)
- [Architecture Overview](#architecture-overview)
- [Project Structure](#project-structure)
- [Requirements](#requirements)
- [Features](#features)
- [Testing](#testing)

## Introduction

This project is a NY Times Articles Viewer built in Swift, using the MVVM architecture. It fetches and displays a list of the latest articles from The New York Times using their public API. The app provides a simple and intuitive interface for users to browse trending articles and see details of individual articles.

## Technologies Used
  **Swift**: The programming language used to build the app. 
  
  **SwiftUI**: For building a declarative, dynamic user interface.  
  
  **Combine**: For handling asynchronous events and API calls.  
  
  **NY Times API**: The backend service providing the latest articles.  
  

## Architecture Overview

The MVVM-Coordinator pattern is a scalable architectural pattern for SwiftUI applications that enhances the Model-View-ViewModel (MVVM) pattern by introducing a Coordinator to manage navigation and app flow. This helps separate responsibilities, making the codebase more modular, testable, and maintainable.

The **MVVM** pattern is split into three main components:

- **Model**: The data and business logic of the app, typically representing real-world objects or server responses.
  
- **View**: The SwiftUI views that define the UI. The `View` subscribes to updates from the `ViewModel`.

- **ViewModel**: The intermediary between the `Model` and the `View`. It contains presentation logic and transforms the model data to a format that the view can display.

```plaintext

┌────────────┐       ┌──────────────┐       ┌───────────┐
│   Model    │──────▶│  ViewModel   │──────▶│   View    │
└────────────┘       └──────────────┘       └───────────┘

```


## Project Structure
The project is organized in the following way:

```plaintext

|
├── Coordinator                         # Contains Navigation path to handle routing
│   └── ArticleFlowCoordinator.swift    # Example for Coordinator
│
|
├── Models/                             # Data structures
│   └── ArticleListResponse.swift       # Example model for ArticleList data
│
├── ViewModels/                         # ViewModel logic for each screen/view
│   └── ArticleListViewModel.swift
│
├── Views/                              # SwiftUI Views
│   └── ArticleListView.swift
│
├── Services/                           # Networking and other services
│   └── ArticleListRepo.swift
│
├── Endpoint/                           # API hiiting related details
│   └── ArticleListEndpoint.swift
│
└── Tests/
    └── ArticleListViewModelTest        # Unit tests for ViewModels and services

```


## Requirements

iOS 16.0+  
Swift 5.0+  
Xcode 15.0+ or later

## Features

    **1. Separation of Concerns:** Avoids placing navigation logic inside ViewModels or Views.

    **2. Improved Testability:** ViewModels remain independent of navigation, making them easier to test.

    **3. Scalability:** Helps organize large projects by decoupling navigation logic from UI components.

    **4. Better Code Reusability:** Coordinators handle the flow of the app, allowing ViewModels to focus on business logic.

## Testing
This project includes unit tests for the ViewModel. The XCTest framework is used to test the business logic in the ViewModel.

You can run the tests in Xcode:

    1. Select the project scheme.
    2. Press Cmd + U to run all tests.

