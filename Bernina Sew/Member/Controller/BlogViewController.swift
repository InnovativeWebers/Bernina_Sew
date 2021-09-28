//
//  BlogViewController.swift
//  Bernina Sew
//
//  Created by lunarian on 01/06/2020.
//

import UIKit
import SnapKit
import Firebase
import FirebaseStorage


class BlogViewController: UIViewController {
    
    
    let blogTableView = Tools.setUpTableView()
    let offset = 20
    
    var blogs: [BlogModel] = []
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus"), for: .normal)
        
        return button
    }()
    
    let instructionLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 2
        lbl.text = "No posts yet. \n Click ➕ to post a blog."
        lbl.textAlignment = .center
        return lbl
    }()
    
    @objc func addAction(sender: UIButton){
        sender.showAnimation {
            let vc = AddPostViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }


        
    
    override func viewWillAppear(_ animated: Bool)  {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Member"
        
        if let blogArray = UserDefaults.standard.object(forKey: "Blogs") as? NSData {
            blogs = NSKeyedUnarchiver.unarchiveObject(with: blogArray as Data) as! [BlogModel]
        }

        addButton.addTarget(self, action: #selector(addAction(sender:)), for: .touchUpInside)
        Tools.setHeight(addButton, 45)
        Tools.setWidth(addButton, 45)
        
        blogTableView.delegate = self
        blogTableView.dataSource = self
        blogTableView.register(BlogCell.self, forCellReuseIdentifier: "BlogCell")
        blogTableView.reloadData()
        
        let imageIcon = UIImage(systemName: "person.and.person.fill", withConfiguration: K.symbolConfig)?.withTintColor(K.brandRed, renderingMode: .alwaysOriginal)
        self.tabBarController?.tabBar.items![1].selectedImage = imageIcon

        view.addSubview(blogTableView)
        view.addSubview(addButton)
        view.addSubview(instructionLabel)
        blogTableView.rowHeight = 116
        
        if blogs.count == 0 {
            instructionLabel.isHidden = false
            blogTableView.isHidden = true
        }else {
            instructionLabel.isHidden = true
            blogTableView.isHidden = false
        }
        
        instructionLabel.snp.makeConstraints { make  in
            make.centerX.equalTo(view.snp_centerX)
            make.centerY.equalTo(view.snp_centerY)
        }
        
        blogTableView.separatorStyle = .none
        
        blogTableView.snp.makeConstraints { make  in
            make.top.equalTo(view).offset(10)
            make.left.equalTo(view).offset(offset)
            make.right.equalTo(view).offset(-offset)
            make.bottom.equalTo(view).offset(-10)
        }
        
        addButton.snp.makeConstraints { make  in
            make.bottom.equalTo(view).offset(-offset)
            make.right.equalTo(view).offset(-offset)
        }
        
        

    }
}

extension BlogViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlogCell", for: indexPath) as! BlogCell
        cell.dateLabel.text = blogs[indexPath.row].Time
        cell.titleLabel.text = blogs[indexPath.row].BlogTitle
        cell.selectionStyle = .none
        return cell
    }
}
