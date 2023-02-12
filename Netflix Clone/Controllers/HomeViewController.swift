//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Adem KOYAN on 11.02.2023.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: -DEF
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    } ()
    
    //MARK: -LC
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        let headerHeroView = HeaderHeroImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 375))
        homeFeedTable.tableHeaderView =  headerHeroView
        
        configureNavBar()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    private func configureNavBar() {
        var image = UIImage(named: "netflix-logo")
        image = image?.withRenderingMode(.alwaysOriginal)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: image, style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
    }
}
    
    //MARK: -EXT
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    //Tablonun kendini tekrarlama sayısı
    func numberOfSections(in tableView: UITableView) -> Int {
        20
    }
    //Tablonun eleman\satır sayısı
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
