//
//  ViewController.swift
//  P4
//
//  Created by Thibault Bernard on 28/12/2020.
//

import UIKit

class ViewController: UIViewController {
    
    var currentButton : UIButton!
    let selected = UIImage(named: "Selected.png") as UIImage?
    
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var Button4: UIButton!
    @IBOutlet weak var SwipeUp: UILabel!
    @IBOutlet weak var Trame1: UIButton!
    @IBOutlet weak var Trame2: UIButton!
    @IBOutlet weak var Trame3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        Button1.isHidden = true
        Trame1.setImage(selected, for: .normal)
        
        
    let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
    swipeUp.direction = .up
    self.view.addGestureRecognizer(swipeUp)
    let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
    swipeLeft.direction = .left
    self.view.addGestureRecognizer(swipeLeft)
        
    }
    
    @IBAction func trameTapButton(sender : UIButton) {
        currentButton = sender
        if currentButton == Trame1 {
            Button1.isHidden = true
            Button2.isHidden = false
            Button3.isHidden = false
            Button4.isHidden = false
            Trame1.setImage(selected, for: .normal)
            Trame2.setImage(nil, for: .normal)
            Trame3.setImage(nil, for: .normal)
        }
        if currentButton == Trame2 {
            Button1.isHidden = false
            Button2.isHidden = false
            Button3.isHidden = false
            Button4.isHidden = true
            Trame1.setImage(nil, for: .normal)
            Trame2.setImage(selected, for: .normal)
            Trame3.setImage(nil, for: .normal)
        }
        if currentButton == Trame3 {
            Button1.isHidden = false
            Button2.isHidden = false
            Button3.isHidden = false
            Button4.isHidden = false
            Trame1.setImage(nil, for: .normal)
            Trame2.setImage(nil, for: .normal)
            Trame3.setImage(selected, for: .normal)
        }
        
        
    }

    @IBAction func didTapButton(sender : UIButton) {
        currentButton = sender
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
        
            
            switch swipeGesture.direction {
            case .up:
                print("up")
                if let image = Button1.backgroundImage(for: .normal){
                let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
                present(vc, animated: true)
                }
            case .left:
                print("left")
            default:
                break
            }
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
