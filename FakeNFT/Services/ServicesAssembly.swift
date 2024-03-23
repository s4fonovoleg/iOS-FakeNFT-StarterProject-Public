final class ServicesAssembly {
    
    private let networkClient: NetworkClient
    private let nftStorage: NftStorage
    
    var profileService: ProfileServiceProtocol {
        ProfileService( networkClient: networkClient )
    }
    
    var nftService: NftService {
        NftServiceImpl(
            networkClient: networkClient,
            storage: nftStorage
        )
    }
    
    init(
        networkClient: NetworkClient,
        nftStorage: NftStorage
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
    }
}
