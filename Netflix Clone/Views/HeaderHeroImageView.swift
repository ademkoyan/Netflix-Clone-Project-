//
//  HeaderHeroImageView.swift
//  Netflix Clone
//
//  Created by Adem KOYAN on 12.02.2023.
//

import UIKit

class HeaderHeroImageView: UIView {

    //MARK: -DEF
    private let headerImageView: UIImageView = {
        let headerView = UIImageView()
        headerView.contentMode = .scaleAspectFill
        headerView.clipsToBounds = true
       // headerView.image = UIImage(named: "theBoys")
        return headerView
    }()
    
    private let playButton: UIButton = {
        let playButton = UIButton()
        playButton.setTitle("Play", for: .normal)
        playButton.layer.borderColor = UIColor.white.cgColor
        playButton.layer.borderWidth = 2
        playButton.layer.cornerRadius = 15
        playButton.translatesAutoresizingMaskIntoConstraints = false
        return playButton
    }()
    
    private let downloadButton: UIButton = {
        let downloadButton = UIButton()
        downloadButton.setTitle("Download", for: .normal)
        downloadButton.layer.borderColor = UIColor.white.cgColor
        downloadButton.layer.borderWidth = 2
        downloadButton.layer.cornerRadius = 15
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        return downloadButton
    }()
    
    
    //MARK: -LC
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        addConstraite()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerImageView.frame = bounds
    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        layer.addSublayer(gradientLayer)
    }
    
    private func addConstraite() {
        let playButtonConstraite = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 75),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 110)
        ]
        
        let downloadButtonConstraite = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -75),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 110)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraite)
        NSLayoutConstraint.activate(downloadButtonConstraite)
    }
    
    public func configure(with model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterUrl)") else {
            return
        }
        
        headerImageView.sd_setImage(with: url)
    }

}

    //MARK: -EXT
