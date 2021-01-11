//
//  ViewController.swift
//  P4
//
//  Created by Thibault Bernard on 28/12/2020.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var Button4: UIButton!
    @IBOutlet weak var Button1Image: UIImageView!
    @IBOutlet weak var Button2Image: UIImageView!
    @IBOutlet weak var Button3Image: UIImageView!
    @IBOutlet weak var Button4Image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func didTapButton() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }

}



extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info : [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue : "UIImagePickerControllerEditedImage")] as? UIImage {
            Button1.setBackgroundImage(image, for: .normal)
            Button1.imageView?.layer.transform = CATransform3DMakeScale(0.0, 0.0, 0.0)
        }

        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker : UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
}






/*
extension ViewController : UISwipeGestureRecognizer{
    
}


if UIApplication.shared.statusBarOrientation.isPortrait {
           maGesture?.direction = .up
       } else {
           maGesture?.direction = .left
       }

puis

  if (maGestureReg.direction == .up) {
           translation = CGAffineTransform(translationX: 0, y: -maGrille.frame.maxY)
       }
       else if (maGestureReg.direction == .left) {
           translation = CGAffineTransform(translationX: -maGrille.frame.maxX, y: 0)
       }
*/
