
import UIKit

class CustomTableViewCell: UITableViewCell {

    lazy private var avatarImage: UIImageView = {
       let imageView = UIImageView()
        imageView.frame.size = CGSize(width: 80, height: 80)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy private var titleName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var ageTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImage.image = nil
    }
    
   private func setupUI(){
        
        guard avatarImage.superview == nil else {return}
        let mainStackView = UIStackView(arrangedSubviews: [titleName, ageTitle])
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
       mainStackView.axis = .horizontal
      // mainStackView.alignment = .center
       mainStackView.distribution = .fillProportionally
        contentView.addSubview(avatarImage)
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
//            avatarImage.heightAnchor.constraint(equalToConstant: 80),
//            avatarImage.widthAnchor.constraint(equalToConstant: 80),
            avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avatarImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            avatarImage.widthAnchor.constraint(equalToConstant: avatarImage.frame.height),
            
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 30),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])
    }
    
    
    func configure(user: User){
        self.avatarImage.image = user.avatar
        self.ageTitle.text = String(user.age)
        self.titleName.text = user.name
       
    }
    
}






extension UITableViewCell {
   static var cellId: String{
       return String(describing: self)
   }
}
