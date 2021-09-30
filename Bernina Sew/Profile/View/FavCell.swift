import UIKit
import SDWebImage

class FavCell: UITableViewCell {

    let patternImageView = Tools.setUpImageView()
    let container = Tools.setUpContainerView()
    let patternName = UILabel()
    let patternDescription = UILabel()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
        patternName.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        patternDescription.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        patternDescription.numberOfLines = 2

        contentView.addSubview(container)
        container.addSubview(patternName)
        container.addSubview(patternDescription)
        container.addSubview(patternImageView)

        
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
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
