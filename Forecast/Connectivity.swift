//
//  Connectivity.swift
//  Forecast
//  Copyright © 2017 Mikko Rouru. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
