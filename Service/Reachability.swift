//
//  Reachability.swift
//  News
//
//  Created by Donia Ashraf on 7/17/21.
//  Copyright © 2021 Donia Ashraf. All rights reserved.
//

import Foundation
import Alamofire
class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
