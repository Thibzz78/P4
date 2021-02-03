//
//  Extension.swift
//  P4
//
//  Created by Thibault Bernard on 02/02/2021.
//

import UIKit

 extension UIView {
    
 func viewToImage() -> UIImage {
        let render = UIGraphicsImageRenderer(bounds: self.bounds)
        
        return render.image { context in
            self.layer.render(in: context.cgContext)
        }
    }
 }
