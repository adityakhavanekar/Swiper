//
//  AddProductViewController.swift
//  Swiper
//
//  Created by Neosoft on 23/08/23.
//

import UIKit

class AddProductViewController: UIViewController {

    @IBOutlet weak var internalView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        internalView.layer.cornerRadius = 10
        internalView.applyLiftedShadowEffectToView(cornerRadius: 10)
        cancelButton.layer.cornerRadius = 10
        cancelButton.clipsToBounds = true
        cancelButton.applyLiftedShadowEffectToView(cornerRadius: 10)
        addButton.layer.cornerRadius = 10
        addButton.clipsToBounds = true
        addButton.applyLiftedShadowEffectToView(cornerRadius: 10)
    }
}
