//
//  Extension.swift
//  Swiper
//
//  Created by Neosoft on 22/08/23.
//

import Foundation
import UIKit

extension UIView{
    func applyLiftedShadowEffectToView(cornerRadius:CGFloat,opacity:Float) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = 6
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
    }
}
