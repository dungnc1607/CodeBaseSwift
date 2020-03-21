//
//  APIUserService.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire

final class APIUserService {
    
    // MARK: - Properties
    
    public static let shared = APIUserService.init()
    
    private lazy var service: APIService = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = APIServiceConfiguration.timeoutIntervalForRequest
        configuration.timeoutIntervalForResource = APIServiceConfiguration.timeoutIntervalForResource
        let manager = Alamofire.SessionManager(configuration: configuration)
        let service = APIService.init(with: manager)
        return service
    }()
    
    // MARK: - Dealloc
    
    deinit {
        
    }

    // MARK: - Initialization
    
    // MARK: - Public Methods
    
    func fetchUser(requestModel: BaseRequestModel = BaseRequestModel.init()) -> Observable<BaseResponseModel<User>> {
        requestModel.endpoint = APIEndpoints.User.getUser
        return service.request(with: requestModel)
                .do(onNext: { response in
                    guard requestModel.shouldCacheResponse, let user = response.data else { return }
//                    DatabaseService.shared.addOrUpdateObject(with: user)
                })
                .observeOn(MainScheduler.instance)
                .share(replay: APIServiceConfiguration.shareReplayCount)
    }
}
