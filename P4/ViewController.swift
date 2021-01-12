//
//  ViewController.swift
//  P4
//
//  Created by Thibault Bernard on 28/12/2020.
//

import UIKit

class ViewController: UIViewController {
    
    var currentButton : UIButton!
    
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var Button4: UIButton!
    @IBOutlet weak var SwipeUp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        SwipeUp.add
        
        
    }

    @IBAction func didTapButton(sender : UIButton) {
        currentButton = sender
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    
    }
    
    @IBAction func share(){
        shareImage()
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == .up {
                swipeGesture.direction = .up
            } else {
                swipeGesture.direction = .left
            }
            
            if (swipeGesture.direction == .up) {
                print("is up")
            }
            else if (swipeGesture.direction == .left) {
                print("is left")
            }
        }
        
    }
    
    @objc func shareImage() {
        if let image = Button1.backgroundImage(for: .normal){
            let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
            present(vc, animated: true)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
        func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info : [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                currentButton.setBackgroundImage(image, for: .normal)
                currentButton.imageView?.layer.transform = CATransform3DMakeScale(0.0, 0.0, 0.0)
            }

            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker : UIImagePickerController){
            picker.dismiss(animated: true, completion: nil)
        }
}
