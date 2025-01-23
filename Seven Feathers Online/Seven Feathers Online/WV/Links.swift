import SwiftUI

class Links {
    
    static let shared = Links()
    
    static let winStarData = "https://nordicinvest.pro/date"
    //"?page=test"
    
    @AppStorage("finalUrl") var finalURL: URL?
    
    
}