////
////  DatabaseServiceType.swift
////  SampleProject
////
////  Created by Squall on 2/4/20.
////  Copyright © 2020 Squall. All rights reserved.
////
//
//import Foundation
//import RxSwift
//import RealmSwift
//
//typealias DatabaseServicesResults = Results
//
//enum DatabaseServiceError: Error {
//    case getObjectFailed(Any)
//    case getObjectsFailed
//    case addOrUpdateObjectFailed(Any)
//    case addOrUpdateObjectsFailed(Any)
//    case deleteObjectFailed(Any)
//}
//
//protocol DatabaseServiceType where Self: DatabaseService {
//    @discardableResult func getObject<T: Object>(with primaryKey: Any) -> Observable<T>
//    @discardableResult func getObjects<T: Object>() -> Observable<DatabaseServicesResults<T>>
//    @discardableResult func addOrUpdateObject<T: Object>(with object: T) -> Observable<T>
//    @discardableResult func addOrUpdateObjects<T: Object>(with objects: [T]) -> Observable<[T]>
//    @discardableResult func deleteObject<T: Object>(with object: T) -> Observable<Void>
//}
