//
//  ViewController.swift
//  MemeMe2.0
//
//  Created by HtetWaiYanSwe on 02/06/2021.
//

import UIKit

import UIKit

class MeMeEditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var topNavigationBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var bottomTextField: UITextField!
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  -4
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.navigationController?.navigationBar.backgroundColor = .clear
        //self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.isHidden = true
        goToInitialUIState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
        prepareTextViewUI(textFields: [topTextField, bottomTextField])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        
       
    }
    
    func prepareTextViewUI(textFields: [UITextField])  {
        for txt in textFields {
            txt.defaultTextAttributes = memeTextAttributes
            txt.delegate = self
            txt.textAlignment = .center
        }
    }
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        pickImage(source: .photoLibrary)
    }
    
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        pickImage(source: .camera)
    }
    
    func pickImage(source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = source
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        shareButton.isEnabled = true
        cancelButton.isEnabled = true
        
        if let image = info[UIImagePickerController.InfoKey.originalImage]as? UIImage {
            imagePickerView.image = image
            
        }
        dismiss(animated: true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM"{
            textField.text = ""
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if topTextField.text == "" {
            topTextField.text = "TOP"
        }
        else if bottomTextField.text == "" {
            bottomTextField.text = "BOTTTOM"
        }
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if(bottomTextField.isEditing){
            view.frame.origin.y -= getKeyboardHeight(notification)
            
        }
        
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        view.frame.origin.y = 0
        
    }
    
    @IBAction func Share_Click(_ sender: UIBarButtonItem) {
        let memedImage = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.save()
                self.dismiss(animated: true, completion: nil)
                self.goToInitialUIState()
            }
            else {
                print("Share Cancel")
            }
                
            
        }
        
        present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func Cancel_Click(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func goToInitialUIState() {
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        imagePickerView.image = nil
        shareButton.isEnabled = false
        cancelButton.isEnabled = false
    }
    
    func generateMemedImage() -> UIImage {
        
        // Hide toolbar and navbar
        setToolBarSate(hidden: true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        setToolBarSate(hidden: false)
        
        return memedImage
    }
    
    func setToolBarSate(hidden: Bool){
        topNavigationBar.isHidden = hidden
        toolBar.isHidden = hidden
    }
    
    func save(){
        // Create the meme
        let meme = MeMe(topText: topTextField.text!, bottomText:bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        
        let object = UIApplication.shared.delegate
            let appDelegate = object as! AppDelegate
            appDelegate.memes.append(meme)
    }
    
    
}

