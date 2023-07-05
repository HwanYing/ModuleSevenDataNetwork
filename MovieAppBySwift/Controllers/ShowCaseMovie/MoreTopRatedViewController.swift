//
//  MoreTopRatedViewController.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/6/23.
//

import UIKit

class MoreTopRatedViewController: UIViewController, MovieItemDelegate {
   
    @IBOutlet weak var showCaseCollectionView: UICollectionView!
    var initData: MovieListResult?

    private var data: [MovieResult] = []

    private var totalPages: Int = 1
    private var currentPage: Int = 1
//    private let networkAgent = MovieDBNetworkAgent.shared
    private let movieModel1 : MovieModel1 = MovieModelImpl1.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
        initState()
        navigationItem.title = "Top Rated Movie List"
    }
    
    private func initView() {
        setUpCollectionView()
    }
    private func initState() {
        currentPage = initData?.page ?? 1
        totalPages = initData?.totalPages ?? 1
        
        data.append(contentsOf: initData?.results ?? [MovieResult]())
        showCaseCollectionView.reloadData()
    }
    
    func setUpCollectionView() {
        showCaseCollectionView.dataSource = self
        showCaseCollectionView.delegate = self
        showCaseCollectionView.showsHorizontalScrollIndicator = false
        showCaseCollectionView.showsVerticalScrollIndicator = false
        showCaseCollectionView.contentInset = UIEdgeInsets.init(top: 10, left: 16, bottom: 10, right: 16)
        
        showCaseCollectionView.registerCollectionCell(identifier: ShowCaseCollectionViewCell.identifier)
        if let layout = showCaseCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
    private func fetchData(page: Int) {
        movieModel1.getTopRatedMovieList(page: page) { (result) in
            switch result {
            case .success(let data):
                self.data.append(contentsOf: data)
                self.showCaseCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
//        networkAgent.getTopRatedMovieList(page: page) { result in
//            switch result {
//            case .success(let data):
//                self.data.append(contentsOf: data.results ?? [MovieResult]())
//                self.showCaseCollectionView.reloadData()
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
    func onTapMovieItem(id: Int) {
        self.navigateToMovieDetailsVC(movieId: id)
    }
    

    func onTapMovie(id: Int, type: VideoType) {
        switch type {
        case .movie:
            navigateToMovieDetailsVC(movieId: id)
        case .series:
            navigateToSeriesDetailsVC(id: id)
        }
    }
    
}
extension MoreTopRatedViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCollectionCell(identifier: ShowCaseCollectionViewCell.identifier, indexPath: indexPath) as ShowCaseCollectionViewCell
        cell.data = data[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let isAtLastRow = indexPath.row == (data.count - 1)
        let hasMorePage = currentPage < totalPages
        if isAtLastRow && hasMorePage {
            currentPage = currentPage + 1
            // make apicall
            fetchData(page: currentPage)
        }
    }
    
}

extension MoreTopRatedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth: CGFloat = collectionView.frame.width
        let itemHeight: CGFloat = (itemWidth / 16) * 9
        return CGSize(width: itemWidth, height: itemHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        self.onTapMovieItem(id: item.id ?? 0)
    }
}
