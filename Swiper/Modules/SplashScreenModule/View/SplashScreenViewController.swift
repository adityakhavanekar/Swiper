//
//  SplashScreenViewController.swift
//  Swiper
//
//  Created by Neosoft on 23/08/23.
//

import UIKit

class SplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.transitionToMainScreen()
        }
    }
    
    private func transitionToMainScreen(){
        let mainViewController = HomeViewController()
        pushWithFadeOut(mainViewController)
    }
    
    func pushWithFadeOut(_ viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .fade
        transition.subtype = .fromRight
        view.window?.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(viewController, animated: false)
    }
    
}
