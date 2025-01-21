//
//  DeviceInfo.swift
//  Seven Feathers Online
//
//  Created by Dias Atudinov on 20.01.2025.
//


import UIKit

class DeviceInfo {
    static let shared = DeviceInfo()
    
    var deviceType: UIUserInterfaceIdiom
    
    private init() {
        self.deviceType = UIDevice.current.userInterfaceIdiom
    }
}