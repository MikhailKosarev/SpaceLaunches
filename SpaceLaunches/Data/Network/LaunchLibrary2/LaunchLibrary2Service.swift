import Moya
import RxSwift

/// A service for interacting with the LaunchLibrary2API and fetching launch-related data.
///
/// This service conforms to the `LaunchService` protocol and utilizes the `NetworkService` protocol
/// for handling network requests.
struct LaunchLibrary2Service: LaunchService, NetworkService {

    let provider = MoyaProvider<LaunchLibrary2API>()

    func getLaunchList(type: LaunchListNetworkType,
                       parameters: GetLaunchListRequestParameters) -> Single<LaunchListResponse> {
        fetchDecodedData(.getLaunchList(type: type, parameters: parameters))
    }

    func getLaunch(_ id: String) -> Single<LaunchResponse> {
        fetchDecodedData(.getLaunch(id: id))
    }
}
