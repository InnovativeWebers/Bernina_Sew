
import UIKit
import SDWebImage
import SCLAlertView

class PatternTableViewCell: UITableViewCell {

    let patternImageView = Tools.setUpImageView()
    let container = Tools.setUpContainerView()
    let patternName = UILabel()
    let patternDescription = UILabel()
    let addButton = Tools.setUpButton("Add", K.brandRed, 16)
    var patternID: Int?
    var patternImageUrl: String?
    
    @objc func addPressed(sender: UIButton){
        sender.showAnimation { [self] in
            
            var patternArray = [Pattern]()
            if let data = UserDefaults.standard.object(forKey: "Patterns") as? NSData {
            patternArray = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [Pattern]
               }
            
            let pattern = Pattern(ID: patternID!, Name: patternName.text!, Image: patternImageUrl!, Description: self.patternDescription.text!)
            
            patternArray.append(pattern)
            
            let data = NSKeyedArchiver.archivedData(withRootObject: patternArray)
            UserDefaults.standard.setValue(data, forKey: "Patterns")
            
            SCLAlertView().showTitle("Added", subTitle: "Check your favorites", style: .success, colorStyle: 0x29BB89)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
        patternName.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        patternDescription.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        patternDescription.numberOfLines = 2
        addButton.addTarget(self, action: #selector(addPressed(sender:)), for: .touchUpInside)
        
        contentView.addSubview(container)
        container.addSubview(patternName)
        container.addSubview(patternDescription)
        container.addSubview(patternImageView)
        container.addSubview(addButton)
        
        container.snp.makeConstraints { make  in
            make.top.equalTo(contentView).offset(8)
            make.left.equalTo(contentView).offset(15)
            make.bottom.equalTo(contentView).offset(-8)
            make.right.equalTo(contentView).offset(-15)
        }
        
        patternImageView.snp.makeConstraints { make  in
            make.top.equalTo(container).offset(15)
            make.left.equalTo(container).offset(15)
        }
        
        patternName.snp.makeConstraints { make  in
            make.top.equalTo(container).offset(20)
            make.left.equalTo(patternImageView.snp_rightMargin).offset(20)
        }
        
        patternDescription.snp.makeConstraints { make  in
            make.top.equalTo(patternName.snp_bottomMargin).offset(20)
            make.left.equalTo(patternImageView.snp_rightMargin).offset(20)
        }
        
        Tools.setWidth(addButton, 60)
        addButton.snp.makeConstraints { make  in
            make.centerY.equalTo(container)
            make.right.equalTo(container).offset(-20)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
