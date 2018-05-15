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
    
    func createTestGraph() -> Building {
        let nodes = createNodes()
        let edge17 = Edge(first: nodes[1], second: nodes[7], length: 3, weight: 1)
        let edge26 = Edge(first: nodes[2], second: nodes[6], length: 1, weight: 1)
        let edge46 = Edge(first: nodes[4], second: nodes[6], length: 1, weight: 1)
        let edge67 = Edge(first: nodes[6], second: nodes[7], length: 1, weight: 1)
        let edge78 = Edge(first: nodes[7], second: nodes[8], length: 1, weight: 1)
        let edge89 = Edge(first: nodes[8], second: nodes[9], length: 1, weight: 1)
        let edge910 = Edge(first: nodes[9], second: nodes[10], length: 1, weight: 1)
        let edge59 = Edge(first: nodes[5], second: nodes[9], length: 1, weight: 1)
        let edge310 = Edge(first: nodes[3], second: nodes[10], length: 1, weight: 1)
        let edge811 = Edge(first: nodes[8], second: nodes[11], length: 1, weight: 1)
        //
        let edge1112 = Edge(first: nodes[11], second: nodes[12], length: 1, weight: 1)
        //
        let edge1219 = Edge(first: nodes[12], second: nodes[19], length: 1, weight: 1)
        let edge1315 = Edge(first: nodes[13], second: nodes[15], length: 1, weight: 1)
        let edge1516 = Edge(first: nodes[15], second: nodes[16], length: 1, weight: 1)
        let edge1519 = Edge(first: nodes[15], second: nodes[19], length: 1, weight: 1)
        let edge1917 = Edge(first: nodes[19], second: nodes[17], length: 1, weight: 1)
        let edge1920 = Edge(first: nodes[19], second: nodes[20], length: 1, weight: 1)
        let edge1820 = Edge(first: nodes[18], second: nodes[20], length: 1, weight: 1)
        let edge2021 = Edge(first: nodes[20], second: nodes[21], length: 1, weight: 1)
        let edge1421 = Edge(first: nodes[14], second: nodes[21], length: 1, weight: 1)
        let edges1 = [edge17, edge26, edge46, edge67, edge78, edge89, edge910, edge59, edge310, edge811]
        let edges2 = [edge1219, edge1315, edge1516, edge1519, edge1917, edge1920, edge1820, edge2021, edge1421]
        
        return Building(floors: [Floor(number: 1, edges: edges1),
                                 Floor(number: 2, edges: edges2)])
    }
    
    func createNodes() -> [Node] {
        let initialEdges: [Edge] = []
        let node1 = Node(type: .exit, number: nil, coordinates: Point(x: 4, y: 1), edges: initialEdges)
        let node2 = Node(type: .auditorium, number: 1, coordinates: Point(x: 2, y: 5), edges: initialEdges)
        let node3 = Node(type: .auditorium, number: 2, coordinates: Point(x: 7, y: 5), edges: initialEdges)
        let node4 = Node(type: .auditorium, number: 3, coordinates: Point(x: 2, y: 3), edges: initialEdges)
        let node5 = Node(type: .auditorium, number: 4, coordinates: Point(x: 6, y: 3), edges: initialEdges)
        let node6 = Node(type: .link, number: nil, coordinates: Point(x: 2, y: 4), edges: initialEdges)
        let node7 = Node(type: .link, number: nil, coordinates: Point(x: 4, y: 4), edges: initialEdges)
        let node8 = Node(type: .link, number: nil, coordinates: Point(x: 5, y: 4), edges: initialEdges)
        let node9 = Node(type: .link, number: nil, coordinates: Point(x: 6, y: 4), edges: initialEdges)
        let node10 = Node(type: .link, number: nil, coordinates: Point(x: 7, y: 4), edges: initialEdges)
        let node11 = Node(type: .stairs, number: nil, coordinates: Point(x: 5, y: 5), edges: initialEdges)
        let node12 = Node(type: .stairs, number: nil, coordinates: Point(x: 4, y: 5), edges: initialEdges)
        let node13 = Node(type: .auditorium, number: 5, coordinates: Point(x: 3, y: 5), edges: initialEdges)
        let node14 = Node(type: .auditorium, number: 6, coordinates: Point(x: 7, y: 5), edges: initialEdges)
        let node15 = Node(type: .auditorium, number: 7, coordinates: Point(x: 3, y: 4), edges: initialEdges)
        let node16 = Node(type: .auditorium, number: 8, coordinates: Point(x: 3, y: 2), edges: initialEdges)
        let node17 = Node(type: .auditorium, number: 9, coordinates: Point(x: 4, y: 2), edges: initialEdges)
        let node18 = Node(type: .auditorium, number: 10, coordinates: Point(x: 6, y: 2), edges: initialEdges)
        let node19 = Node(type: .link, number: nil, coordinates: Point(x: 4, y: 4), edges: initialEdges)
        let node20 = Node(type: .link, number: nil, coordinates: Point(x: 6, y: 4), edges: initialEdges)
        let node21 = Node(type: .link, number: nil, coordinates: Point(x: 7, y: 4), edges: initialEdges)
        return [node1, node2, node3, node4, node5, node6, node7, node8, node9, node10,
                node11, node12, node13, node14, node15, node16, node17, node18, node19, node20, node21]
        
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
