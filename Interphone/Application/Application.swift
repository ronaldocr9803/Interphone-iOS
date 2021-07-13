
import Foundation
import UIKit
import RxSwift
import RxCocoa

final class Application: NSObject {
    static let shared = Application()
    
    var window: UIWindow?
    
    let provider: DataManager
    let navigator: Navigator
    
    private override init() {
        provider = AppDataManager(authProvider: AppNetworking.appNetworking())
        navigator = Navigator(provider: provider)
    }
    
    func presentInitialScreen(in window: UIWindow) {
        self.window = window
        navigator.show(segue: .splash,
                       sender: nil,
                       transition: .root(in: window, animation: nil))
    }
    
    func showMain(screen: Navigator.Scene = .home){
        navigator.show(segue: screen,
                       sender: nil,
                       transition: .root(in: window!, animation: .transitionCrossDissolve ))
    }
    

    
}
