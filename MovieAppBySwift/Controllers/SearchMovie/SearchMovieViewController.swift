//
//  SearchMovieViewController.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/6/18.
//

import UIKit

class SearchMovieViewController: UIViewController, MovieItemDelegate {

    @IBOutlet weak var collectionViewSearch: UICollectionView!

    private let searchBar = UISearchBar()

    private var searchResult:  [MovieResult] = []
    private let itemSpacing: CGFloat = 10
    private let numberOfItemsPerRow = 3
    private var currentPage: Int = 1
    private var totalPage: Int = 1
    
    private let networkAgent = MovieDBNetworkAgent.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.placeholder = "Search..."
        searchBar.delegate = self
        searchBar.searchTextField.textColor = .white
        
        navigationItem.titleView = searchBar
        
       setUpCollectionView()
    
    }
    
    func setUpCollectionView() {
        collectionViewSearch.delegate = self
        collectionViewSearch.dataSource = self
        collectionViewSearch.showsHorizontalScrollIndicator = false
        collectionViewSearch.showsVerticalScrollIndicator = false
        collectionViewSearch.contentInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        collectionViewSearch.registerCollectionCell(identifier: PopularFilmAndSeriesCollectionViewCell.identifier)
        if let layout = collectionViewSearch.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
    
    func searchContent(keyword: String, page: Int) {
        networkAgent.searchMovieByKeyword(query: keyword, page: "\(page)") { data in
            self.totalPage = data.totalPages ?? 1
            self.searchResult.append(contentsOf: data.results ?? [MovieResult]())
            self.collectionViewSearch.reloadData()
        } failure: { error in
            print(error.description)
        }
    }
    func onTapMovieItem(id: Int) {
        navigateToMovieDetailsVC(movieId: id)
    }
    
}

extension SearchMovieViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCollectionCell(identifier: PopularFilmAndSeriesCollectionViewCell.identifier, indexPath: indexPath) as PopularFilmAndSeriesCollectionViewCell
        cell.data = searchResult[indexPath.row]
        cell.onTapItem = { id in
            self.navigateToMovieDetailsVC(movieId: id)
        }

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let isAtLastRow = indexPath.row == self.searchResult.count - 1
        let hasMorePages = self.currentPage < self.totalPage
        if (isAtLastRow && hasMorePages) {
            currentPage = currentPage + 1
            searchContent(keyword: searchBar.text ?? "", page: currentPage)
        }
    }
    
}

extension SearchMovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing: CGFloat = (itemSpacing * CGFloat(numberOfItemsPerRow - 1)) + collectionView.contentInset.left + collectionView.contentInset.right
        let itemWidth: CGFloat = (collectionView.frame.width / CGFloat(numberOfItemsPerRow)) - (totalSpacing / CGFloat(numberOfItemsPerRow))
        
        return CGSize(width: itemWidth, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = searchResult[indexPath.row]
        self.onTapMovieItem(id: item.id ?? 0)
    }
}
extension SearchMovieViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        if let data = searchBar.text {
            self.currentPage = 1
            self.totalPage = 1
            self.searchResult.removeAll()
            searchContent(keyword: data, page: currentPage)
        }
    }
}
