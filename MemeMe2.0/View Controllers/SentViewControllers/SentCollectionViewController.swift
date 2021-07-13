//
//  SentCollectionViewController.swift
//  MemeMe2.0
//
//  Created by HtetWaiYanSwe on 07/06/2021.
//

import UIKit

class SentCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var memes: [MeMe]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        flowLayout.scrollDirection = .vertical
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print(memes.count)
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MeMeCell", for: indexPath) as! MeMeCollectionViewCell
        
        cell.meMeImage.image = memes[indexPath.row].memedImage
        return cell
    }
    
    
    @IBAction func gotToMeMeEdit(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MeMeEditViewController") as! MeMeEditViewController

        let navigationController: UINavigationController = UINavigationController(rootViewController: viewController)

        navigationController.modalPresentationStyle = .fullScreen

        present(navigationController, animated: true, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MeMeDetailViewController") as! MeMeDetailViewController
        
        detailController.image = memes[indexPath.row].memedImage!
        
        self.navigationController!.pushViewController(detailController, animated: true)
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
