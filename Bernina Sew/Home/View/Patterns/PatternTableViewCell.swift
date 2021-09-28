
import UIKit
import SDWebImage
import SCLAlertView

class PatternTableViewCell: UITableViewCell {

    let patternImageView = Tools.setUpImageView()
    let container = Tools.setUpContainerView()
    let patternName = UILabel()
    let patternDescription = UILabel()
    let addButton = Tools.setUpButton("Add to fav", K.brandRed, 16)
    
    @objc func addPressed(sender: UIButton){
        sender.showAnimation {
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
        
        Tools.setHeight(addButton, 45)
        Tools.setWidth(addButton, 100)
        addButton.snp.makeConstraints { make  in
            make.centerY.equalTo(container)
            make.right.equalTo(container).offset(-20)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
