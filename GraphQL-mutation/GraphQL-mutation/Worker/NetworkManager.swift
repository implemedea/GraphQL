import Foundation
import Apollo

class Network {
    static let shared = Network()
    
    private(set) lazy var apollo: ApolloClient = {

        let cache = InMemoryNormalizedCache()
        let store1 = ApolloStore(cache: cache)
        let authPayloads = ["x-hasura-admin-secret": "eJiNdfzgDDuYvyoKDYNvsvTn2CzxS2u6A2VFQZJVz5eFsSSME1zmjC82jgZ3MsO9"]
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = authPayloads
        
        let client1 = URLSessionClient(sessionConfiguration: configuration, callbackQueue: nil)
        let provider = NetworkInterceptorProvider(client: client1, shouldInvalidateClientOnDeinit: true, store: store1)
        
        let url = URL(string: "https://fleet-sponge-36.hasura.app/v1/graphql")!
        
        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                                 endpointURL: url)
        
        return ApolloClient(networkTransport: requestChainTransport,
                            store: store1)
    }()
}

class NetworkInterceptorProvider: DefaultInterceptorProvider {
    override func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(CustomInterceptor(), at: 0)
        return interceptors
    }
}

class CustomInterceptor: ApolloInterceptor {

    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Swift.Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        request.addHeader(name: "x-hasura-admin-secret", value: "eJiNdfzgDDuYvyoKDYNvsvTn2CzxS2u6A2VFQZJVz5eFsSSME1zmjC82jgZ3MsO9")

        print("request :\(request)")
        print("response :\(String(describing: response))")

        chain.proceedAsync(request: request,
                           response: response,
                           completion: completion)
    }
}
