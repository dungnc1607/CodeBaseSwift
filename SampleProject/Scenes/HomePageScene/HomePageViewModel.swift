//
//  HomePageViewModel.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import UIKit

class HomePageViewModel: BaseViewModel {
    
    //MARK: Properties
    
    var name: String
    
    required init(with name: String) {
        self.name = name
        super.init()
    }
}
