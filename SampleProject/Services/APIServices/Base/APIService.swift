//
//  APIService.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire
import ObjectMapper

typealias ResponseDataValid = [String: Any]

struct APIServiceConfiguration {
    static let timeoutIntervalForRequest: TimeInterval = 10
    static let timeoutIntervalForResource: TimeInterval = 10
    static let shareReplayCount: Int = 1
}

final class APIService {

    // MARK: - Properties
    
    private let manager: SessionManager
    private let scheduler: ConcurrentDispatchQueueScheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    
    // MARK: - Dealloc
    
    deinit {
        
    }
    
    // MARK: - Initialization
    
    init(with manager: SessionManager = SessionManager.default) {
        self.manager = manager
    }
    
    // MARK: - Public Methods
    
    func request<T: Mappable>(with input: BaseRequestModel) -> Observable<T> {
        return sendRequest(with: input)
            .map { data -> T in
                if let json = data as? ResponseDataValid, let item = T(JSON: json) {
                    return item
                } else {
                    throw ResponseDataError.invalidResponseData(data: data)
                }
            }
    }

    func requestArray<T: Mappable>(with input: BaseRequestModel) -> Observable<[T]> {
        return sendRequest(with: input)
            .map { data -> [T] in
                if let jsonArray = data as? [ResponseDataValid] {
                    return Mapper<T>().mapArray(JSONArray: jsonArray)
                } else {
                    throw ResponseDataError.invalidResponseData(data: data)
                }
            }
    }
    
    // MARK: - Private Methods
    
    private func sendRequest(with input: BaseRequestModel) -> Observable<Any> {
        return manager.rx
            .request(input.httpMethod,
                     input.endpoint,
                     parameters: input.parameters,
                     encoding: input.encoding,
                     headers: input.headers)
            .observeOn(scheduler)
//            .debug()
            .flatMap { dataRequest -> Observable<DataResponse<Any>> in
                dataRequest
                .rx.responseJSON()
            }
//            .do(onNext: { dataResponse in
//                print("Call API ended with \(dataResponse)")
//            })
            .map { dataResponse -> Any in
                return try self.process(with: dataResponse)
            }
    }
    
    private func process(with response: DataResponse<Any>) throws -> Any {
        
        let error: Error
        switch response.result {
            case .success(let value):
                guard let statusCode = response.response?.statusCode else {
                    error = ResponseError.noStatusCode
                    break
                }
                switch statusCode {
                    case 200:
                        return value
                    
                    case ResponseError.notModified.rawValue:
                        error = ResponseError.notModified
                    
                    case ResponseError.badRequest.rawValue:
                        error = ResponseError.badRequest
                    
                    case ResponseError.unauthorized.rawValue:
                        error = ResponseError.unauthorized
                    
                    case ResponseError.accessDenied.rawValue:
                        error = ResponseError.accessDenied
                    
                    case ResponseError.notFound.rawValue:
                        error = ResponseError.notFound
                    
                    case ResponseError.methodNotAllowed.rawValue:
                        error = ResponseError.methodNotAllowed
                    
                    case ResponseError.validate.rawValue:
                        error = ResponseError.validate
                    
                    case ResponseError.serverError.rawValue:
                        error = ResponseError.serverError
                    
                    case ResponseError.badGateway.rawValue:
                        error = ResponseError.badGateway
                    
                    case ResponseError.serviceUnavailable.rawValue:
                        error = ResponseError.serviceUnavailable
                    
                    case ResponseError.gatewayTimeout.rawValue:
                        error = ResponseError.gatewayTimeout
                    
                    case ResponseError.noConnection.rawValue:
                        error = ResponseError.noConnection
                    
                    case ResponseError.timeOutError.rawValue:
                        error = ResponseError.timeOutError
                    
                    default:
                        error = ResponseError.noStatusCode
                }
                print(value)
            
            case .failure(let e):
                error = e
        }
        throw error
    }
}
