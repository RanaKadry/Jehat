//
//  SponserRepositoryImp.swift
//  Jihat
//
//  Created by Peter Bassem on 16/10/2021.
//

import Foundation

class SponserRepositoryImp: SponserRepository {
    
    private let remoteSponsersDataSource = RemoteSponsersDataSource()
    
    func getSponsers(completion: @escaping (Result<APIResponse<[SponsersModel]>, NetworkErrorType>) -> Void) {
        remoteSponsersDataSource.getFromRemote(from: .getSponsers, completion: completion)
    }
}
