//
//  UpcomingTableViewCell.swift
//  Netflix Clone
//
//  Created by Mohamed Hany on 12/01/2023.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {

    static let identifier = "UpcomingTableViewCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let playButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.rectangle" , withConfiguration: UIImage.SymbolConfiguration(pointSize: 35))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let infoButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "info.circle" , withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let alertButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "bell" , withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(playButton)
        contentView.addSubview(infoButton)
        contentView.addSubview(alertButton)
        
        applayConstraints()
    }
    
    private func applayConstraints(){
        let posterImageViewConstraints = [
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            posterImageView.widthAnchor.constraint(equalToConstant: 120)
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 50)
        ]
        
        let dateLabelConstraints = [
            dateLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
            dateLabel.centerYAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        ]
        
        let palyButtonConstraints = [
            playButton.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 30),
            playButton.centerYAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 40)
        ]
        
        let alertButtonConstraints = [
            alertButton.leadingAnchor.constraint(equalTo: infoButton.leadingAnchor, constant: -40),
            alertButton.centerYAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 40)
        ]
        
        let infoButtonConstraints = [
            infoButton.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            infoButton.centerYAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 40)
        ]
                
        NSLayoutConstraint.activate(posterImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(dateLabelConstraints)
        NSLayoutConstraint.activate(palyButtonConstraints)
        NSLayoutConstraint.activate(infoButtonConstraints)
        NSLayoutConstraint.activate(alertButtonConstraints)
    }
    
    public func configure(with model: MovieViewModel){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        posterImageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.titleName
        dateLabel.text = model.date
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
