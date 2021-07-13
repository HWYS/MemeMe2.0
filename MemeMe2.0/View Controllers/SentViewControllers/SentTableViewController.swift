//
//  SentTabelViewController.swift
//  MemeMe2.0
//
//  Created by HtetWaiYanSwe on 03/06/2021.
//

import UIKit

class SentTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var memes: [MeMe]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeMeCell", for: indexPath) as! MeMeTableViewCell
        let meMe = memes[indexPath.row]
        cell.meMeImage.image = meMe.memedImage
        cell.meMeText.text = meMe.topText! + " "+meMe.bottomText!
        return cell
    }
    
    
    @IBAction func goToMeMeEditor(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MeMeEditViewController") as! MeMeEditViewController

        let navigationController: UINavigationController = UINavigationController(rootViewController: viewController)

        navigationController.modalPresentationStyle = .fullScreen

        present(navigationController, animated: true, completion: nil)
        //tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
