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
    
    let sectionTitles: [String] = ["Trending Movies", "Populer", "Trending Tv", "Upcoming Movies","Top Rated"]
    
    //MARK: -LC
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        let headerHeroView = HeaderHeroImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 375))
        homeFeedTable.tableHeaderView =  headerHeroView
        
        configureNavBar()
        getTrendingMovies()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    private func configureNavBar() {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 0, height: 34)
        button.setImage(UIImage(named: "netflix-logo"), for: .normal)
        //can add a target here for button
        
        //Adding to Constraite(width-height) for leftBarButton using custom image
        let leftButton = UIBarButtonItem(customView: button)
        let currWidth = leftButton.customView?.widthAnchor.constraint(equalToConstant: 44)
        currWidth?.isActive = true
        let currHeight = leftButton.customView?.heightAnchor.constraint(equalToConstant: 34)
        currHeight?.isActive = true
        self.navigationItem.leftBarButtonItem = leftButton
        
        navigationItem.title = "Netflix"
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
    }
    
    private func getTrendingMovies() {
        APICaller.shared.getTrendingMovies{ _ in
            
        }
    }
}
    
    //MARK: -EXT
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    //Tablonun kendini tekrarlama sayısı
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOfSet = view.safeAreaInsets.top
        let offSet = scrollView.contentOffset.y + defaultOfSet
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offSet))
    }
}
