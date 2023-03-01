//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Adem KOYAN on 11.02.2023.
//

import UIKit

enum Sections: Int {
    case TrendinMovies = 0
    case TrendindTv = 1
    case Populer = 2
    case Upcoming = 3
    case TopRated = 4
    
}


class HomeViewController: UIViewController {

    //MARK: -DEF
    private var randomTrendingMovies: Title?
    private var headerHeroView: HeaderHeroImageView?
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    } ()
    
    let sectionTitles: [String] = ["Trending Movies", "Trending Tv", "Populer", "Upcoming Movies","Top Rated"]
    
    //MARK: -LC
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        headerHeroView = HeaderHeroImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 375))
        homeFeedTable.tableHeaderView =  headerHeroView
        
        configureNavBar()
        congifureHeroHeaderView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    private func congifureHeroHeaderView() {
        APICaller.shared.getTrendingMovies { [weak self] result in
            switch result {
            case.success(let titles):
                let selectedTitle = titles.randomElement()
                self?.randomTrendingMovies = selectedTitle
                
                self?.headerHeroView?.configure(with: TitleViewModel(titleName: selectedTitle?.original_title ?? "", posterUrl: selectedTitle?.poster_path ?? ""))
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
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
        
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.TrendinMovies.rawValue:
            APICaller.shared.getTrendingMovies { result in switch result {
            case.success(let titles):
                cell.configure(with: titles)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
            
        case Sections.TrendindTv.rawValue:
            APICaller.shared.getTrendingTvs { result in switch result {
            case.success(let titles):
                cell.configure(with: titles)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        case Sections.Populer.rawValue:
            APICaller.shared.getPopuler { result in switch result {
            case.success(let titles):
                cell.configure(with: titles)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        case Sections.Upcoming.rawValue:
            APICaller.shared.getUpComingMovies { result in switch result {
            case.success(let titles):
                cell.configure(with: titles)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRated { result in switch result {
            case.success(let titles):
                cell.configure(with: titles)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        default:
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
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOfSet = view.safeAreaInsets.top
        let offSet = scrollView.contentOffset.y + defaultOfSet
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offSet))
    }
}

extension HomeViewController: CollectionTableViewCellDelegate {
    func CollectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
