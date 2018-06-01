//
//  FacultiesVC.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 18.09.17.
//  Copyright © 2017 Екатерина Рыжова. All rights reserved.
//

import UIKit

class FacultiesVC: UIViewController, Routable {
    let storyboardName = "Main"
    @IBOutlet var container: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    fileprivate var previousScrollOffset: CGFloat = 0
    let dataSource = FacultiesDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(FacultyCell.nib, forCellWithReuseIdentifier: "FacultyCell")
        title = "Компании-арендаторы"
        dataSource.createFakeData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK: UICollectionViewDataSource
extension FacultiesVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell!
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacultyCell", for: indexPath)
        return cell
    }
    
}

// MARK: UICollectionViewDelegate
extension FacultiesVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        let model = dataSource[indexPath]
        FacultiesCellBuilder.populate(cell: cell, with: model)
        if let cell = cell as? FacultyCell {
            cell.separator.isHidden = indexPath.row == dataSource.count - 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let navigator = self.navigationController else { return }
        
        let router = Router()
        router.presentFaculty(controller: navigator, faculty: dataSource[indexPath], for: indexPath.row)
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension FacultiesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 70)
    }
    
}

// MARK: UIScrollViewDelegate
extension FacultiesVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
//        let velocity = currentOffset - previousScrollOffset
        previousScrollOffset = currentOffset
    }
}

