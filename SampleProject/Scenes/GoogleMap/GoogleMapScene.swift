//
//  GoogleMapScene.swift
//  SampleProject
//
//  Created by Squall on 2/24/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import UIKit
import GoogleMaps
import RxGoogleMaps
import RxCocoa
import RxSwift

class GoogleMapScene: BaseViewController, BindableType {

    // MARK: - Properties
    
    var viewModel: GoogleMapViewModel!
    
    fileprivate lazy var googleMap: GMSMapView = {
        let googleMap = GMSMapView.init()
        googleMap.contentMode = .scaleAspectFit
        googleMap.backgroundColor = .cyan
        return googleMap
    }()
    
    fileprivate lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager.init()
        
        return locationManager
    }()
    
    fileprivate lazy var button0: UIButton = {
        let btn = UIButton.init()
        btn.setTitle("Button 0", for: .normal)
        btn.backgroundColor = .brown
        return btn
    }()
    
    fileprivate lazy var button1: UIButton = {
        let btn = UIButton.init()
        btn.setTitle("Button 1", for: .normal)
        btn.backgroundColor = .brown
        return btn
    }()
    
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        locationManager.requestWhenInUseAuthorization()
        
        googleMap.settings.myLocationButton = true
        
        
//
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//        let googleMap = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        self.view = googleMap
        
        let startLocationManager = googleMap.rx.didTapMyLocationButton.take(1).publish()
        _ = startLocationManager.subscribe({ [weak self] _ in
            self?.locationManager.requestWhenInUseAuthorization()
            if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){

                guard let currentLocation = self!.locationManager.location else {
                    return
                }
                print(currentLocation.coordinate.latitude, "/", currentLocation.coordinate.longitude)
            }
        })
        _ = startLocationManager.map { _ in true }.bind(to: googleMap.rx.myLocationEnabled)
        startLocationManager.connect().disposed(by: rx.disposeBag)

        googleMap.rx.handleTapMarker { marker in
            print("Handle tap marker: \(marker.title ?? "") (\(marker.position.latitude), \(marker.position.longitude))")
            
            return false
        }

//        googleMap.rx.handleTapOverlay { overlay in
//            print("Handle tap overlay: \(overlay.title ?? "")")
//
//        }

//        googleMap.rx.handleMarkerInfoWindow { marker in
//            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 180, height: 60))
//            label.textAlignment = .center
//            label.textColor = UIColor.brown
//            label.font = UIFont.boldSystemFont(ofSize: 16)
//            label.backgroundColor = UIColor.yellow
//            label.text = marker.title
//            return label
//        }
//
//        googleMap.rx.handleMarkerInfoContents { marker in
//            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
//            label.textAlignment = .center
//            label.textColor = UIColor.green
//            label.font = UIFont.boldSystemFont(ofSize: 16)
//            label.backgroundColor = UIColor.yellow
//            label.text = "Picles"
//            return label
//        }

        googleMap.rx.handleTapMyLocationButton {
            print("Handle my location button")
            return false
        }

//        googleMap.rx.willMove.asDriver()
//            .drive(onNext: { _ in
//                print("Will move") })
//            .disposed(by: rx.disposeBag)
//
//        googleMap.rx.didChange.asDriver()
//            .drive(onNext: {
//                print("Did change position: \($0)") })
//            .disposed(by: rx.disposeBag)
//
//        googleMap.rx.idleAt
//            .subscribe(onNext: { print("Idle at coordinate: \($0)") })
//            .disposed(by: rx.disposeBag)
//
//        googleMap.rx.didTapAt.asDriver()
//            .drive(onNext: { print("Did tap at coordinate: \($0)") })
//            .disposed(by: rx.disposeBag)
//
//        googleMap.rx.didLongPressAt.asDriver()
//            .drive(onNext: { print("Did long press at coordinate: \($0)") })
//            .disposed(by: rx.disposeBag)
//
//        googleMap.rx.didTapInfoWindowOf.asDriver()
//            .drive(onNext: { print("Did tap info window of marker: \($0)") })
//            .disposed(by: rx.disposeBag)
//
//        googleMap.rx.didLongPressInfoWindowOf.asDriver()
//            .drive(onNext: { print("Did long press info window of marker: \($0)") })
//            .disposed(by: rx.disposeBag)
//
//        googleMap.rx.didTapAtPoi.asDriver()
//            .drive(onNext: { (placeID, name, coordinate) in
//                print("Did tap POI: [\(placeID)] \(name) (\(coordinate.latitude), \(coordinate.longitude))")
//            })
//            .disposed(by: rx.disposeBag)
//
//        googleMap.rx.didTapMyLocationButton.asDriver()
//            .drive(onNext: { _ in print("Did tap my location button") })
//            .disposed(by: rx.disposeBag)
//
//        googleMap.rx.didCloseInfoWindowOfMarker.asDriver()
//            .drive(onNext: { print("Did close info window of marker: \($0)") })
//            .disposed(by: rx.disposeBag)
//
//        googleMap.rx.didBeginDragging.asDriver()
//            .drive(onNext: { print("Did begin dragging marker: \($0)") })
//            .disposed(by: rx.disposeBag)
//
//        googleMap.rx.didEndDragging.asDriver()
//            .drive(onNext: { print("Did end dragging marker: \($0)") })
//            .disposed(by: rx.disposeBag)
//
//        googleMap.rx.didDrag.asDriver()
//            .drive(onNext: { print("Did drag marker: \($0)") })
//            .disposed(by: rx.disposeBag)
//
//        googleMap.rx.didStartTileRendering
//            .subscribe(onNext: { print("Did start tile rendering") })
//            .disposed(by: rx.disposeBag)
//
//        googleMap.rx.didFinishTileRendering
//            .subscribe(onNext: { print("Did finish tile rendering") })
//            .disposed(by: rx.disposeBag)
//
//        googleMap.rx.snapshotReady
//            .subscribe(onNext: { print("Snapshot ready") })
//            .disposed(by: rx.disposeBag)

        googleMap.rx.myLocation
            .subscribe(onNext: { location in
                if let l = location {
                    print("My location: (\(l.coordinate.latitude), \(l.coordinate.longitude))")
                } else {
                    print("My location: nil")
                }
            })
            .disposed(by: rx.disposeBag)

        googleMap.rx.selectedMarker.asDriver()
            .drive(onNext: { selected in
                if let marker = selected {
                    print("Selected marker: \(marker.title ?? "") (\(marker.position.latitude), \(marker.position.longitude))")
                } else {
                    print("Selected marker: nil")
                }
            })
            .disposed(by: rx.disposeBag)

        do {
            let s0 = googleMap.rx.selectedMarker.asObservable()
            let s1 = s0.skip(1)

            Observable.zip(s0, s1) { ($0, $1) }
                .subscribe(onNext: { (prev, cur) in
                    if let marker = prev {
                        marker.icon = #imageLiteral(resourceName: "marker_normal")
                    }
                    if let marker = cur {
                        marker.icon = #imageLiteral(resourceName: "marker_selected")
                    }
                })
                .disposed(by: rx.disposeBag)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let center = CLLocationCoordinate2D(latitude: -23.565314, longitude: -46.651857)
               let place0 = CLLocationCoordinate2D(latitude: -23.549932, longitude: -46.653737)

               let camera = GMSCameraPosition.camera(withLatitude: center.latitude, longitude: center.longitude, zoom: 14, bearing: 30, viewingAngle: 0)
               googleMap.camera = camera

               do {
                   let marker = GMSMarker(position: center)
                   marker.title = "Hello, RxSwift"
                   marker.isDraggable = true
                   marker.icon = #imageLiteral(resourceName: "marker_normal")
                   marker.map = googleMap

               }

               do {
                   let marker = GMSMarker(position: place0)
                   marker.title = "Hello, GoogleMaps"
                   marker.isDraggable = true
                   marker.icon = #imageLiteral(resourceName: "marker_normal")
                   marker.map = googleMap

                   //Rotate marker upsidedown
                   button0.rx.tap.map{ 180.0 }
                       .bind(to: marker.rx.rotation.asObserver())
                    .disposed(by: rx.disposeBag)

                   //Rotate marker back
                   button1.rx.tap.map{ 0 }
                       .bind(to: marker.rx.rotation.asObserver())
                    .disposed(by: rx.disposeBag)
               }

               do {
                   let circle = GMSCircle()
                   circle.title = "Circle"
                   circle.radius = 500
                   circle.isTappable = true
                   circle.position = center
                   circle.fillColor = UIColor.green.withAlphaComponent(0.3)
                   circle.strokeColor = UIColor.green.withAlphaComponent(0.8)
                   circle.strokeWidth = 4
                   circle.map = googleMap

                   //Change circle color to red
//                   button0.rx.tap.map{ UIColor.red }
//                       .bind(to: circle.rx.fillColor.asObserver())
//                    .disposed(by: rx.disposeBag)
//
//                   //Change circle color to red
//                   button1.rx.tap.map{ UIColor.green }
//                       .bind(to: circle.rx.fillColor.asObserver())
//                    .disposed(by: rx.disposeBag)

               }

//               do {
//                   //Enable traffic
//                   button0.rx.tap.map { true }
//                       .bind(to: googleMap.rx.trafficEnabled.asObserver())
//                    .disposed(by: rx.disposeBag)
//
//                   //Disable traffic
//                   button1.rx.tap.map { false }
//                       .bind(to: googleMap.rx.trafficEnabled.asObserver())
//                    .disposed(by: rx.disposeBag)
//
//                   //Animated Zoom
//                   button0.rx.tap.map { 14 }
//                       .bind(to: googleMap.rx.zoomToAnimate)
//                    .disposed(by: rx.disposeBag)
//
//                   //Move to camera position
//                   button1.rx.tap
//                       .map { GMSCameraPosition.camera(withLatitude: place0.latitude, longitude: place0.longitude, zoom: 8, bearing: 10, viewingAngle: 30) }
//                       .bind(to: googleMap.rx.cameraToAnimate)
//                    .disposed(by: rx.disposeBag)
//
//                   //Enable zoom gesture
//                   button0.rx.tap.map { true }
//                       .bind(to: googleMap.rx.zoomGesturesEnabled)
//                    .disposed(by: rx.disposeBag)
//
//                   //Disable zoom gesture
//                   button1.rx.tap.map { false }
//                       .bind(to: googleMap.rx.zoomGesturesEnabled)
//                    .disposed(by: rx.disposeBag)
//
//               }
    }
    
    //MARK: - Override Methods
    
    override func setupUI() {
        super.setupUI()
    
        view.addSubview(googleMap)
        googleMap.addSubview(button0)
        googleMap.addSubview(button1)
        
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        googleMap.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        button0.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(20 * Constants.UI.displayScale)
            make.width.equalTo(100 * Constants.UI.displayScale)
            make.height.equalTo(50 * Constants.UI.displayScale)
        }

        button1.snp.makeConstraints { (make) in
            make.top.equalTo(button0.snp.bottom).offset(10 * Constants.UI.displayScale)
            make.leading.equalTo(button0.snp.leading)
            make.width.equalTo(100 * Constants.UI.displayScale)
            make.height.equalTo(50 * Constants.UI.displayScale)
        }
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
    }
}

// MARK: - BindableType

extension GoogleMapScene {
    
    func bindViewModel() {
        
    }
    
    func executeViewModelAction() {
        
    }

}
