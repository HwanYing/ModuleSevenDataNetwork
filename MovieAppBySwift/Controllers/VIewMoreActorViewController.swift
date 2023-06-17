//
//  VIewMoreActorViewController.swift
//  Jun17
//
//  Created by 梁世仪 on 2023/6/17.
//

import UIKit

class VIewMoreActorViewController: UIViewController {

    @IBOutlet weak var collectionViewActors: UICollectionView!
    
    var initData: ActorListResult?
    
    private var data: [ActorInfoResponse] = []
    
    private let itemSpacing: CGFloat = 10
    private let numberOfItemsPerRow = 3
    private var totalPages: Int = 1
    private var currentPage: Int = 1
    private let networkAgent = MovieDBNetworkAgent.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    private func initView() {
        setupCollectionView()
    }
    private func initState() {
        currentPage = initData?.page ?? 1
        totalPages = initData?.totalPages ?? 1
        
        data.append(contentsOf: initData?.results ?? [ActorInfoResponse]())
        collectionViewActors.reloadData()
    }
    
    private func fetchData(page: Int) {
        networkAgent.getPeopleList(page: page, success: { (respData) in
            self.data.append(contentsOf: respData.results ?? [ActorInfoResponse]())
            self.collectionViewActors.reloadData()
        }, failure: { (error) in
            print(error)
        })


    }
    
    func setupCollectionView() {
        collectionViewActors.delegate = self
        collectionViewActors.dataSource = self
        collectionViewActors.showsHorizontalScrollIndicator = false
        collectionViewActors.showsVerticalScrollIndicator = false
        collectionViewActors.contentInset = UIEdgeInsets.init(top: 16, left: 16, bottom: 16, right: 16)
        if let layout = collectionViewActors.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
}

extension VIewMoreActorViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCollectionCell(identifier: BestActorsCollectionViewCell.identifier, indexPath: indexPath) as BestActorsCollectionViewCell
        cell.data1 = data[indexPath.row]
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
extension VIewMoreActorViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing: CGFloat = (itemSpacing * CGFloat(numberOfItemsPerRow - 1)) + collectionView.frame.size.width / 3
        let itemWidth: CGFloat = (collectionView.frame.width / CGFloat(numberOfItemsPerRow)) - (totalSpacing - itemSpacing)
        let itemHeight: CGFloat = itemWidth * 1.5
        return CGSize(width: itemWidth, height: itemHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }
}