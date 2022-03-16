//
//  RemoteSponsersDataSource.swift
//  Jihat
//
//  Created by Peter Bassem on 16/10/2021.
//

import Foundation

class RemoteSponsersDataSource: BaseService {
    
    func getFromRemote(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<[SponsersModel]>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
}
