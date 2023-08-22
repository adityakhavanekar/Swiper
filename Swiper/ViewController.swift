//
//  ViewController.swift
//  Swiper
//
//  Created by Neosoft on 22/08/23.
//

import UIKit

class ViewController: UIViewController {
    var homeViewModel:HomeViewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.getProductListing(completion: { err in
            if err == nil{
                
            }
        })
    }
}

