//
//  ToiletsVC.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 01.06.2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import UIKit

class ToiletsVC: UIViewController, Routable {
    let storyboardName = "Main"
    @IBOutlet var collectionView: UICollectionView!
    fileprivate var previousScrollOffset: CGFloat = 0
    
    let floorCount: Int = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Туалеты"
        collectionView.register(WcCell.nib, forCellWithReuseIdentifier: "WcCell")
    }

}
// MARK: UICollectionViewDataSource
extension ToiletsVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return floorCount
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell!
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WcCell", for: indexPath)
        return cell
    }
    
}

// MARK: UICollectionViewDelegate
extension ToiletsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if let cell = cell as? WcCell {
            cell.headerLabel.text = "\(indexPath.row + 1) этаж"
            cell.leftLabel.text = "пом. \(indexPath.row + 1)30"
            cell.rightLabel.text = "пом. \(indexPath.row + 1)31"
            cell.separator.isHidden = indexPath.row == floorCount - 1
        }
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension ToiletsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 65)
    }
    
}

// MARK: UIScrollViewDelegate
extension ToiletsVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        previousScrollOffset = currentOffset
    }
}
