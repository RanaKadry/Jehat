//
//  SponserRepository.swift
//  Jihat
//
//  Created by Peter Bassem on 16/10/2021.
//

import Foundation

protocol SponserRepository {
    func getSponsers(completion: @escaping (Result<APIResponse<[SponsersModel]>, NetworkErrorType>) -> Void)
}
