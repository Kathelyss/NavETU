//
//  HomeVC.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 17.09.17.
//  Copyright © 2017 Екатерина Рыжова. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet var container: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    fileprivate var previousScrollOffset: CGFloat = 0
    let dataSource = HomeDataSource()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Бизнес-центр Лэтиция"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(HomeCell.nib, forCellWithReuseIdentifier: "HomeCell")
        
        dataSource.createData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = nil
    }
}

// MARK: UICollectionViewDataSource
extension HomeVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell!
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath)
        return cell
    }
    
}

// MARK: UICollectionViewDelegate
extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        let model = dataSource[indexPath]
        HomeCellBuilder.populate(cell: cell, with: model)
        if let cell = cell as? HomeCell {
            cell.separator.isHidden = indexPath.row == dataSource.count - 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let navigator = self.navigationController else { return }
        
        let router = Router()
        router.presentItem(controller: navigator, item: dataSource[indexPath], for: indexPath.row)
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 75)
    }
    
}

// MARK: UIScrollViewDelegate
extension HomeVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
//        let velocity = currentOffset - previousScrollOffset
        previousScrollOffset = currentOffset
    }
}
