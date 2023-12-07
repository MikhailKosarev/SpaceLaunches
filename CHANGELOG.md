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

### Changed

- The project file structure according to the clean approach.
- Set up the `Podfile` to automatic setting the deployment target `15.0` for all dependencies.

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
