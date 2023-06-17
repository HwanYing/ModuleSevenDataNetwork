//
//  ShowCaseTableViewCell.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/4/4.
//

import UIKit

class ShowCaseTableViewCell: UITableViewCell {
    @IBOutlet weak var moreShowCaseLabel: UILabel!
    @IBOutlet weak var showCaseCollectionView: UICollectionView!
    
    @IBOutlet weak var heightForShowCaseCollectionView: NSLayoutConstraint!
    var data: MovieListResult? {
        didSet {
            if let _ = data {
                showCaseCollectionView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        moreShowCaseLabel.underLineText(text: "MORE SHOWCASES")
        setUpCollectionViewCells()
    }
    
    private func setUpCollectionViewCells() {
        showCaseCollectionView.dataSource = self
        showCaseCollectionView.delegate = self
        showCaseCollectionView.registerCollectionCell(identifier: ShowCaseCollectionViewCell.identifier)
        
//        let itemWidth: CGFloat = showCaseCollectionView.frame.width - 60
//        let itemHeight: CGFloat = (itemWidth / 16) * 9
        print("collection view width >>>>> ", showCaseCollectionView.frame.width)
//        heightForShowCaseCollectionView.constant = itemHeight
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension ShowCaseTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return data?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCollectionCell(identifier: ShowCaseCollectionViewCell.identifier, indexPath: indexPath) as ShowCaseCollectionViewCell
        cell.data = data?.results?[indexPath.row]
        return cell
    }
}
extension ShowCaseTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth: CGFloat = collectionView.frame.width - 50
        let itemHeight: CGFloat = (itemWidth / 16) * 9
        return CGSize(width: itemWidth, height: itemHeight)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // -1 for horizontal indicator and -2 for vertical indicator
        ((scrollView.subviews[(scrollView.subviews.count-1)]).subviews[0]).backgroundColor = UIColor(named: "color-yellow")
    }
}
