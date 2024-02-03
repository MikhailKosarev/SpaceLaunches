import Action
import RxCocoa
import RxSwift

/// Use case for retrieving a list of launches.
struct GetLaunchListUseCase: UseCase {

    // MARK: - Internal interface
    /// The service responsible for fetching launch data.
    let launchService: LaunchService
    /// The formatter for date and time.
    let formatter = DateTimeFormatter()

    /// Input parameters for the `GetLaunchListUseCase`.
    struct Input {
        /// The type of launches to retrieve.
        let type: Driver<LaunchListDisplayType>
        /// The maximum number of launches to fetch.
        let limit: Driver<Int>
        /// The offset for paginating through the launch list.
        let offset: Driver<Int>
    }

    /// Produces an `Action` that, when executed, retrieves a list of launches.
    ///
    /// - Parameter input: The input parameters for the use case.
    /// - Returns: An `Action` that produces an array of `LaunchListItem` when executed.
    func produce(input: Input) -> Action<Void, [LaunchListItem]> {
        Action {
            let parameters = Driver.combineLatest(input.limit, input.offset)
                .map { GetLaunchListRequestParameters(limit: $0.0, offset: $0.1) }

            let type = input.type
                .map { mapToLaunchListNetworkType($0) }

            let typeAndParameters = Driver.combineLatest(type, parameters)

            let launchResponses = Observable.just(())
                .withLatestFrom(typeAndParameters)
                .flatMap(launchService.getLaunchList)
                .map { $0.results }

            let launchListItems = launchResponses.map { launchResponse in
                launchResponse.map { mapToLaunchListItem(from: $0) }
            }

            return launchListItems
        }
    }

    // MARK: - Private interface
    private enum Constants {
        static let unknownDate = "Launch date is unknown"
        static let unknownProvider = "Launch provider is unknown"
        static let unknownPad = "Launch pad is unknown"
    }

    private func mapToLaunchListNetworkType(_ displayType: LaunchListDisplayType) -> LaunchListNetworkType {
        switch displayType {
        case .upcoming: return .upcoming
        case .previous: return .previous
        case .all: return .all
        }
    }

    private func mapToLaunchListItem(from launchResponse: LaunchResponse) -> LaunchListItem {
        LaunchListItem(
            id: launchResponse.id,
            imageURL: URL(string: launchResponse.image ?? ""),
            name: launchResponse.name,
            net: getFormattedDate(from: launchResponse.net),
            launchServiceProvider: launchResponse.launchServiceProvider?.name ?? Constants.unknownProvider,
            location: launchResponse.pad?.location?.name ?? Constants.unknownPad
        )
    }

    private func getFormattedDate(from net: String?) -> String {
        if let net,
           let formattedDate = formatter.getLongDateWithShortTime(from: net) {
            return formattedDate
        } else {
            return Constants.unknownDate
        }
    }
}
