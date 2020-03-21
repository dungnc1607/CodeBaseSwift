////
////  DatabaseService.swift
////  SampleProject
////
////  Created by Squall on 2/4/20.
////  Copyright © 2020 Squall. All rights reserved.
////
//
//import UIKit
//
//import Foundation
//import RealmSwift
//import RxSwift
//import RxRealm
//
//class DatabaseService: DatabaseServiceType {
//    
//    // MARK: - Properties
//    
//    public static let shared = DatabaseService.init()
//    
//    // MARK: - Dealloc
//    
//    deinit {
//        
//    }
//    
//    // MARK: - Initialization
//    
//    // MARK: - Private Methods
//    
//    private func tryRealm<T>(with action: (Realm) throws -> T) -> T? {
//        do {
//            let realm = try Realm()
//            return try action(realm)
//        } catch let error {
//            print("Failed \(#function) realm with error: \(error)")
//            return nil
//        }
//    }
//}
//
//// MARK: - DatabaseServiceType
//
//extension DatabaseService {
//    
//    @discardableResult func getObject<T: Object>(with primaryKey: Any) -> Observable<T> {
//        let result = tryRealm { realm -> Observable<T> in
//            guard let object = realm.object(ofType: T.self, forPrimaryKey: primaryKey) else {
//                throw DatabaseServiceError.getObjectFailed(primaryKey)
//            }
//            return Observable.from(object: object)
//        }
//        return result ?? Observable.error(DatabaseServiceError.getObjectFailed(primaryKey))
//    }
//    
//    @discardableResult func getObjects<T: Object>() -> Observable<DatabaseServicesResults<T>> {
//        let result = tryRealm { realm -> Observable<DatabaseServicesResults<T>> in
//            let objects = realm.objects(T.self)
//            return Observable.collection(from: objects)
//        }
//        return result ?? Observable.error(DatabaseServiceError.getObjectsFailed)
//    }
//    
//    @discardableResult func addOrUpdateObject<T: Object>(with object: T) -> Observable<T> {
//        let result = tryRealm { realm -> Observable<T> in
//            do {
//                try realm.write {
//                    realm.add(object, update: true)
//                }
//            }
//            catch { throw DatabaseServiceError.addOrUpdateObjectFailed(object) }
//            return Observable.just(object)
//        }
//        return result ?? Observable.error(DatabaseServiceError.addOrUpdateObjectFailed(object))
//    }
//    
//    @discardableResult func addOrUpdateObjects<T: Object>(with objects: [T]) -> Observable<[T]> {
//        let result = tryRealm { realm -> Observable<[T]> in
//            do {
//                try realm.write {
//                    realm.add(objects, update: true)
//                }
//            }
//            catch { throw DatabaseServiceError.addOrUpdateObjectsFailed(objects) }
//            return Observable.just(objects)
//        }
//        return result ?? Observable.error(DatabaseServiceError.addOrUpdateObjectsFailed(objects))
//    }
//    
//    @discardableResult func deleteObject<T: Object>(with object: T) -> Observable<Void> {
//        let result = tryRealm { realm -> Observable<Void> in
//            do {
//                try realm.write {
//                    realm.delete(object)
//                }
//            }
//            catch { throw DatabaseServiceError.deleteObjectFailed(object) }
//            return Observable.empty()
//        }
//        return result ?? Observable.error(DatabaseServiceError.deleteObjectFailed(object))
//    }
//}
//
