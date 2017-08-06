//
//  Connectivity.swift
//  Forecast
//
//  Created by Mikko Rouru on 6.8.2017.
//  Copyright © 2017 Mikko Rouru. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
