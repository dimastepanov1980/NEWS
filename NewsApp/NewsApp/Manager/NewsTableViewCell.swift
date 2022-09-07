//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Dmitriy Stepanov on 19.08.2022.
//




import UIKit


class NewsTableViewCell: UITableViewCell {

    static let identifire = "NewsTableViewCell"

    private let newsTitleLable : UILabel = {
        let lable = UILabel()
        lable.numberOfLines = 0
        lable.font = .systemFont(ofSize: 25, weight: .medium)
        return lable
    }()
    
    private let newsSubtitleLable : UILabel = {
        let lable = UILabel()
        lable.numberOfLines = 0
        lable.font = .systemFont(ofSize: 16, weight: .regular)
        lable.textColor = .lightGray
        return lable
    }()
    
    private let newsImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitleLable)
        contentView.addSubview(newsSubtitleLable)
        contentView.addSubview(newsImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        newsTitleLable.frame = CGRect(
            x: 20,
            y: 0,
            width: contentView.frame.size.width - 200,
            height: 70 )
        
        newsSubtitleLable.frame = CGRect(
            x: 20,
            y: 70,
            width: contentView.frame.size.width - 200,
            height: contentView.frame.size.height / 2 )
        
        newsImageView.frame = CGRect(
            x: contentView.frame.size.width - 180,
            y: 5,
            width: 160,
            height: contentView.frame.size.height - 10 )
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModed: NewsTableViewCellViewModel) {
        newsTitleLable.text = viewModed.title
        newsSubtitleLable.text = viewModed.subtitle
    // Configure Image
        if let data = viewModed.imageData {
            
            newsImageView.image = UIImage(data: data)
        } else if let url = viewModed.imageURL {
            
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil  else {
                    return
                }
                viewModed.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
            //fetchData
       
        }
        
    }
}
