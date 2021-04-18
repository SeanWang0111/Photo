//
//  ViewController.swift
//  paint_test
//
//  Created by Sean Wang on 2021/3/25.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate
{
    let imagePicker = UIImagePickerController()
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var editPhoto: UIButton!
    @IBOutlet var openPhoto: UIButton!
    {
        didSet
        {
            openPhoto.layer.cornerRadius = 15.0
            openPhoto.layer.masksToBounds = true
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let colorArr =
            ["black","grey","lightgray","white","magenta","red","orangeo","skin","brown","goldyellow","yellow","applegreen","green","darkgreen","airblue","teal","blue","Indigo","purple","pink"]
        let userDefaults = UserDefaults.standard
        userDefaults.set(colorArr, forKey: "fruitName")
        
        editPhoto.isEnabled = false
        
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "image")
        {
            let Vc = segue.destination as! paintVC
            Vc.image11 = imageView.image!
        }
    }
    
    
    @IBAction func openC(_ sender: Any)
    {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        let image = info[.editedImage] as? UIImage
        
        self.imageView.image = image
        self.editPhoto.isEnabled = true
        self.editPhoto.backgroundColor = UIColor.brown
        
        picker.dismiss(animated: true, completion: nil)
    }
}

