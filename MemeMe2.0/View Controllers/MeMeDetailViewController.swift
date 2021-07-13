//
//  MeMeDetailViewController.swift
//  MemeMe2.0
//
//  Created by HtetWaiYanSwe on 12/07/2021.
//

import UIKit

class MeMeDetailViewController: UIViewController {

    @IBOutlet weak var meMeImage: UIImageView!
    
    var image : UIImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        meMeImage.image = image
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
