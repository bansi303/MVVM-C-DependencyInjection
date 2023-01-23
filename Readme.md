# User Management Project

This project is an example of how to use modern iOS development techniques to create a user management system. The project makes use of the following technologies:

1. **Model-View-ViewModel (MVVM) architecture:** This architecture pattern is used to separate the logic of the app from its presentation. This makes the code more maintainable and testable.

2. **Flow Coordinator:** This pattern is used to manage the navigation flow of the app. It helps to keep the ViewControllers decoupled and makes it easier to add new screens.

3. **Swinject:** This is a dependency injection framework for Swift. It is used to manage the dependencies between objects and make the code more testable.

4. **Core Data:** This is Apple's framework for object-relational mapping (ORM) and data persistence. It is used to store and retrieve user data.

5. **RxSwift:** This is a reactive programming framework for Swift. It is used to bind the UI to the data and make the app more responsive.

## Layers

1. **Models:** This layer contains the data models used by the app such as UserModel.

2. **ViewModels:** This layer contains the view models(UserViewModel, UserDetailsViewModel, and UserTableViewCellViewModal) that are used to bind the data to the UI.

3. **Views:** This layer contains the view controllers and their associated views.

4. **Coordinators:** This layer contains the flow coordinators(AppCoordinator and UsersCoordinator) that manage the navigation flow of the app.

5. **Services:** This layer contains the services that are used to interact with the data store (Core Data) and other external resources (e.g. APIs).

The project also includes a set of **unit tests using mockObjects** that demonstrate how to test the different components of the app.

## Dependencies

The project has a few dependencies that need to be installed before you can run it. These dependencies are managed using CocoaPods, so you will need to have [CocoaPods](https://cocoapods.org/) installed on your machine.

Once you have CocoaPods installed, you can run the following command in the root directory of the project to install the dependencies:

```bash
pod install
```

After the dependencies are installed, you should be able to run the project in Xcode.

## Contribution

If you have any ideas or suggestions for this project, please open an issue or pull request.
