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
    
    func showHiddenButtons(isFirstButSh : Bool, issecondButSh : Bool, isthButSh : Bool, isfrButSh : Bool){
                Button1.isHidden = isFirstButSh
                Button2.isHidden = issecondButSh
                Button3.isHidden = isthButSh
                Button4.isHidden = isfrButSh
    }
    
    func setTrameImage(trame1 : UIButton, trame2 : UIButton, trame3 : UIButton, selected : UIImage){
        trame1.setImage(nil, for: .normal)
        trame2.setImage(nil, for: .normal)
        trame3.setImage(selected, for: .normal)
    }
    
    func viewToImage() -> UIImage {
         let render = UIGraphicsImageRenderer(bounds: ImageView.bounds)
         
         return render.image { context in
             ImageView.layer.render(in: context.cgContext)
         }
     }
    
    @IBAction func trameTapButton(sender : UIButton) {
        currentButton = sender
        if currentButton == Trame1 {
            showHiddenButtons(isFirstButSh: false, issecondButSh: true, isthButSh: false, isfrButSh: false)
            Trame1.contentVerticalAlignment = .fill
            Trame1.contentHorizontalAlignment = .fill
            setTrameImage(trame1 : Trame2, trame2: Trame3, trame3: Trame1, selected: selected!)
        }
        if currentButton == Trame2 {
            showHiddenButtons(isFirstButSh: false, issecondButSh: false, isthButSh: false, isfrButSh: true)
            Trame2.contentVerticalAlignment = .fill
            Trame2.contentHorizontalAlignment = .fill
            setTrameImage(trame1 : Trame1, trame2: Trame3, trame3: Trame2, selected: selected!)
        }
        if currentButton == Trame3 {
            showHiddenButtons(isFirstButSh: false, issecondButSh: false, isthButSh: false, isfrButSh: false)
            Trame3.contentVerticalAlignment = .fill
            Trame3.contentHorizontalAlignment = .fill
            setTrameImage(trame1 : Trame1, trame2: Trame2, trame3: Trame3, selected: selected!)
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
        UIView.animate(withDuration: 0.3, animations: {
            self.ImageView.transform = self.translation
        }) { [weak self] success in
            if success {
                self?.shareImage()
            }
        }
    }

    func animateSwipeToLeft(){
        translation = CGAffineTransform(translationX: -ImageView.frame.maxX, y: 0)
        UIView.animate(withDuration: 0.3, animations: {
            self.ImageView.transform = self.translation
        }) { [weak self] success in
            if success {
               self?.shareImage()
            }
        }
    }
    
    func shareImage(){
         let image = viewToImage()
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
  
        vc.completionWithItemsHandler = UIActivityViewController.CompletionWithItemsHandler? { [weak self] activityType, completed, returnedItems, activityError in
                               
                   UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: {
                       self?.ImageView?.transform = CGAffineTransform(translationX: 0, y: 0)
                   }, completion: nil)
               }
              present(vc, animated: true)
    } 
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .up:
                    animateSwipeToUp()
            case .left:
                    animateSwipeToLeft()
                 
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

