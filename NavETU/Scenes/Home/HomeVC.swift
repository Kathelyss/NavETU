//
//  MenuVC.swift
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(HomeCell.nib, forCellWithReuseIdentifier: "HomeCell")
        title = "Home.title".localized
        
        dataSource.createFakeData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createTestGraph() {
        var nodes = [Node(type: .exit, number: nil, coordinates: Point(x: 4, y: 1), edges: nil),
                     Node(type: .auditorium, number: 1, coordinates: Point(x: 2, y: 5), edges: nil),
                     Node(type: .auditorium, number: 2, coordinates: Point(x: 7, y: 5), edges: nil),
                     Node(type: .auditorium, number: 3, coordinates: Point(x: 2, y: 3), edges: nil),
                     Node(type: .auditorium, number: 4, coordinates: Point(x: 6, y: 3), edges: nil),
                     Node(type: .link, number: nil, coordinates: Point(x: 2, y: 4), edges: nil),
                     Node(type: .link, number: nil, coordinates: Point(x: 4, y: 4), edges: nil),
                     Node(type: .link, number: nil, coordinates: Point(x: 5, y: 4), edges: nil),
                     Node(type: .link, number: nil, coordinates: Point(x: 6, y: 4), edges: nil),
                     Node(type: .link, number: nil, coordinates: Point(x: 7, y: 4), edges: nil),
                     Node(type: .stairs, number: nil, coordinates: Point(x: 5, y: 5), edges: nil),
                     Node(type: .stairs, number: nil, coordinates: Point(x: 4, y: 5), edges: nil),
                     Node(type: .auditorium, number: 5, coordinates: Point(x: 3, y: 5), edges: nil),
                     Node(type: .auditorium, number: 6, coordinates: Point(x: 7, y: 5), edges: nil),
                     Node(type: .auditorium, number: 7, coordinates: Point(x: 3, y: 4), edges: nil),
                     Node(type: .auditorium, number: 8, coordinates: Point(x: 3, y: 2), edges: nil),
                     Node(type: .auditorium, number: 9, coordinates: Point(x: 4, y: 2), edges: nil),
                     Node(type: .auditorium, number: 10, coordinates: Point(x: 6, y: 2), edges: nil)]
//        var edges: [Edge]
//        var floors: [Floor]
//        var floor1 = Floor(number: 1, edges: edges)
//        var floor2 = Floor(number: 2, edges: edges)
//        var testGraph = Building(floors: floors)
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
        return CGSize(width: collectionView.bounds.width, height: 70)
    }
    
}

// MARK: UIScrollViewDelegate
extension HomeVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let velocity = currentOffset - previousScrollOffset
        previousScrollOffset = currentOffset
    }
}
