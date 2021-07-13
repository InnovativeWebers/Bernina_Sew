//
//  BlogViewController.swift
//  Bernina Sew
//
//  Created by lunarian on 01/06/2020.
//

import UIKit

class BlogViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Member"
        
        let imageIcon = UIImage(systemName: "person.and.person.fill", withConfiguration: K.symbolConfig)?.withTintColor(K.brandRed, renderingMode: .alwaysOriginal)
        self.tabBarController?.tabBar.items![1].selectedImage = imageIcon
        // Do any additional setup after loading the view.
        

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
