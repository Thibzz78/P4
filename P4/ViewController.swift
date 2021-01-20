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
    var swipeGesture : UISwipeGestureRecognizer?
    private var translation = CGAffineTransform()
    
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var Button4: UIButton!
    @IBOutlet weak var Trame1: UIButton!
    @IBOutlet weak var Trame2: UIButton!
    @IBOutlet weak var Trame3: UIButton!
    @IBOutlet weak var ImageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        Button1.isHidden = true
        Trame1.setImage(selected, for: .normal)
        Trame1.contentVerticalAlignment = .fill
        Trame1.contentHorizontalAlignment = .fill
        
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeGesture?.direction = .up
        self.view.addGestureRecognizer(swipeGesture!)
    }
    
/*
    func showHiddenButtons(bool : isFirstButSh, bool : issecondButSh, bool : isthButSh, bool : isfrButSh ){
                Button1.isHidden = isFirstButSh
                Button2.isHidden = issecondButSh
                Button3.isHidden = isthButSh
                Button4.isHidden = isfrButSh
    }
    
*/
    
    private func viewToImage() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: ImageView.bounds.size)
        return(renderer.image { context in ImageView.drawHierarchy(in: ImageView.bounds, afterScreenUpdates: true)})
      }
    
    
    @IBAction func trameTapButton(sender : UIButton) {
        currentButton = sender
        if currentButton == Trame1 {
            Button1.isHidden = false
            Button2.isHidden = true
            Button3.isHidden = false
            Button4.isHidden = false
            Trame1.setImage(selected, for: .normal)
            Trame1.contentVerticalAlignment = .fill
            Trame1.contentHorizontalAlignment = .fill
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
            Trame2.contentVerticalAlignment = .fill
            Trame2.contentHorizontalAlignment = .fill
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
            Trame3.contentVerticalAlignment = .fill
            Trame3.contentHorizontalAlignment = .fill
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition:
          { (UIViewControllerTransitionCoordinatorContext) -> Void in
            let position = UIDevice.current.orientation
            if position == .portrait{
                self.swipeGesture?.direction = .up
            }else{
                self.swipeGesture?.direction = .left
            }
            
          }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
        })
        super.viewWillTransition(to: size, with: coordinator)
      }
    
    func animateSwipeToUp(){
        translation = CGAffineTransform(translationX: 0, y: -ImageView.frame.maxY)
    }
    func animateSwipeToLeft(){
        translation = CGAffineTransform(translationX: -ImageView.frame.maxX, y: 0)
    }
    
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .up:
                if let image = Button1.image(for: .normal){
                    animateSwipeToUp()
                    let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
                    present(vc, animated: true)
                    }
            case .left:
                if let image = Button1.image(for: .normal){
                    animateSwipeToLeft()
                    let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
                    present(vc, animated: true)
                    }
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




//Reste a faire//


//Swipe : faire translater la view en meme temp que le UIActivityViewController apparait
//alerte icone app 1024x1024
//compiler les photos pour envoyer a la fonction Share()
