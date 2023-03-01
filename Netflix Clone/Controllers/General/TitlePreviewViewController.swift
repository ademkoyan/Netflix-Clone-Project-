//
//  TitlePreviewViewController.swift
//  Netflix Clone
//
//  Created by Adem KOYAN on 27.02.2023.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {

    //MARK: -DEF
    private let webView: WKWebView = {
        let vebView = WKWebView()
        vebView.translatesAutoresizingMaskIntoConstraints = false
        return vebView
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        titleLabel.text = "title"
        return titleLabel
    }()
    
    private let overviewLabel: UILabel = {
        let overviewLabel = UILabel()
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.font = .systemFont(ofSize: 16, weight: .regular)
        overviewLabel.numberOfLines = 0
        overviewLabel.text = "overview"
        return overviewLabel
    }()
    
    private let downloadButton: UIButton = {
        let dbutton = UIButton()
        dbutton.setTitle("Download", for: .normal)
        dbutton.setTitleColor(.white, for: .normal)
        dbutton.layer.cornerRadius = 15
        dbutton.backgroundColor = .red
        dbutton.translatesAutoresizingMaskIntoConstraints = false
        return dbutton
    }()
    //MARK: -LC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        view.backgroundColor = .black
        
        addConstraite()
       
    }
    
    private func addConstraite() {
        let webViewConstraite = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let titleViewConstraite = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        
        let overviewConstraite = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
            
        ]
        
        let downloadButtonConstraite = [
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20),
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        
        NSLayoutConstraint.activate(webViewConstraite)
        NSLayoutConstraint.activate(titleViewConstraite)
        NSLayoutConstraint.activate(overviewConstraite)
        NSLayoutConstraint.activate(downloadButtonConstraite)
    }
    
    func configure(with model: TitlePreviewViewModel) {
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverView
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else { return
            
        }
        
        webView.load(URLRequest(url: url))
    }

}

    //MARK: -EXT
