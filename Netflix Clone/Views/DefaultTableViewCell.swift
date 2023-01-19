//
//  UpcomingTableViewCell.swift
//  Netflix Clone
//
//  Created by Mohamed Hany on 12/01/2023.
//

import UIKit

class DefaultTableViewCell: UITableViewCell {

    static let identifier = "DefaultTableViewCell"
    
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
        label.numberOfLines = 3
        return label
    }()
    
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle" , withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dayLabel)
        contentView.addSubview(monthLabel)
        contentView.addSubview(playButton)
   
        applayConstraints()
    }
    
    private func applayConstraints(){
        let posterImageViewConstraints = [
            posterImageView.leadingAnchor.constraint(equalTo: monthLabel.trailingAnchor, constant: 10),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            posterImageView.widthAnchor.constraint(equalToConstant: 80)
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor),
            titleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 200)
        ]
        
        let monthLabelConstraints = [
            monthLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            monthLabel.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 30)
        ]
        
        let dayLabelConstraints = [
            dayLabel.trailingAnchor.constraint(equalTo: monthLabel.trailingAnchor),
            dayLabel.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 0)
        ]
        
        let palyButtonConstraints = [
            playButton.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            playButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
        ]
        
        NSLayoutConstraint.activate(posterImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(monthLabelConstraints)
        NSLayoutConstraint.activate(dayLabelConstraints)
        NSLayoutConstraint.activate(palyButtonConstraints)
    }
    
    public func configure(with model: MovieViewModel){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        posterImageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.titleName
        monthLabel.text = model.month
        dayLabel.text = model.day
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
