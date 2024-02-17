# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

### Added

- Structures for decoding responses from the LaunchLibrary2 API.
- `SpaceLaunchTests` target and set it up for unit-testing.
- Directory structure for the `SpaceLaunchTests`.
- Tests for `LaunchListResponse`.
- Tests for `LaunchResponse`.
- Environment for the `Moya` to work with `LauchLibrary2` API.
- Tests for `LaunchStatusResponse`.
- Tests for `LaunchServiceProviderResponse`.
- Tests for `RocketResponse`.
- `NetworkError` enum with error descriptions.
- Tests for `RocketConfigurationResponse`.
- `NetworkService` protocol.
- Mocks fo testing `NetworkService`.
- Dependencies for `SpaceLaunchesTests` target.
- Default implementation for `NetworkService` protocol with tests.
- `LaunchService` protocol to define metohds for interacting with launch-related data.
- `LaunchLibrary2Service` for interacting with the LaunchLibrary2API and fetching launch-related data.
- Tests for `MissionResponse`.
- `LaunchListItem` as a representation of a launch item in domain logic.
- `LaunchListDisplayType` as a type of launch list that can be displayed.
- `DateTimeFormatter` utility with tests.
- Tests for `OrbitResponse`.
- `UseCase` protocol to define the structure of a use case in an app.
- Tests for `AgencyResponse`.
- `GetLaunchListUseCase` with tests for retrieving a list of launches.
- `MockLaunchService` for testing purposes.
- `LaunchListViewController` with a default implementation.
- `ViewModel` protocol.
- `Coordinator` protocol.
- `LaunchListSection` as section for the table view containing the launch list.
- `LaunchListInput` protocol.
- `LaunchListOutput` protocol.
- `LaunchListViewModelType` protocol.
- An extension with `Driver`s for the `Action`.
- `LaunchListViewModel` with a conformance to the `LaunchListViewModelType` protocol and tests.
- Tests for `PadResponse`.
- Tests for `LocationResponse`.
- `RxReusableTableViewCell` class for working reactively with a table view.
- Reactive extension with `UIViewController` lifecycle events.
- Implement stubs for `LaunchListResponse'`, `LaunchListItem`, `LaunchResponse`, `LaunchServiceProviderResponse`, `PadResponse`, `LocationResponse`.
- `LaunchListDataSource` and `LaunchListTableViewCell`.
- `default_rocket_launch_image.jpg` to the Assets.

### Changed

- The project file structure according to the clean approach.
- Set up the `Podfile` to automatic setting the deployment target `15.0` for all dependencies.
- Project `rootViewController` from `ViewController` to `LaunchListViewController`.

### Removed

- Default `ViewController`.

## [0.1.0] - 2023-11-23

### Added

- This `CHANGELOG` file to note all changes that have been made between each release of the project.
- `README` file with the main informaiton about the project.
- `LICENSE` to reflect project license information.
- `.gitignore` file to lists all of the files that are local to a project that Git should not push to GitHub.
- Created an initial empty Xcode project with customized configuration.
- Installed and set up the necessary dependencies using `Cocoapods`.
- `SwiftLint` as a script to the build phase and set up the rules.

### Changed

- Change the background color of the screen from wgite to yellow.
- Format default project files according to the lint rules.

### Removed
- Remove unnecessary methods and comments from the default files.
