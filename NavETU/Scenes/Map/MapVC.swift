//
//  MapVC.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 17.09.17.
//  Copyright © 2017 Екатерина Рыжова. All rights reserved.
//

import UIKit

class MapVC: UIViewController, UIScrollViewDelegate {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var mapView: UIImageView!
    @IBOutlet var floorButtons: UIStackView!
    @IBOutlet var firstFloorButton: UIButton!
    @IBOutlet var secondFloorButton: UIButton!
    var graph: Building!
    var pathView: PathView!
    var pathViewIsAdded: Bool = false
    var path: [Node] = []
    
    @IBAction func tapFirstFloorButton(_ sender: UIButton) {
        setBackground(color1: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), color2: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: firstFloorButton, and: secondFloorButton)
        mapView.image = #imageLiteral(resourceName: "floor1")
        pathView.frame = mapView.bounds
        pathView.currentFloorNumber = 0
    }
    
    @IBAction func tapSecondFloorButton(_ sender: UIButton) {
        setBackground(color1: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), color2: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: firstFloorButton, and: secondFloorButton)
        mapView.image = #imageLiteral(resourceName: "floor2")
        pathView.frame = mapView.bounds
        pathView.currentFloorNumber = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Map.title".localized
        mapView.image = #imageLiteral(resourceName: "floor1")
        scrollView.minimumZoomScale = 0.3
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = scrollView.minimumZoomScale
        scrollView.contentSize = mapView.frame.size
        setupFloorButtons()
        
        graph = createBuildingGraph()
        if let tmpBuilding = graph {
            //сделать из графа один большой массив [Node]
            let nodes: [Node] = tmpBuilding.floors.compactMap({$0.nodes}).reduce([], +)
            path = findPath(in: nodes, from: 18, to: 1)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollViewDidZoom(scrollView)
        
        if pathViewIsAdded == false {
            pathView = PathView(frame: mapView.bounds)
            pathView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            mapView.addSubview(pathView)
            pathViewIsAdded = true
            
            pathView.allPathNodes = path
            //для корректного отображения этажа, на кот. расположена sourceNode
            pathView.currentFloorNumber = pathView.allPathNodes[0].floor
            mapView.image = path[0].floor == 0 ? #imageLiteral(resourceName: "floor1") : #imageLiteral(resourceName: "floor2")
            firstFloorButton.backgroundColor = path[0].floor == 0 ? #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            secondFloorButton.backgroundColor = path[0].floor == 1 ? #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mapView
    }
    
    func setBackground(color1: UIColor, color2: UIColor, for button1: UIButton, and button2: UIButton) {
        button1.backgroundColor = color1
        button2.backgroundColor = color2
    }
    
    func setupFloorButtons() {
        firstFloorButton.layer.masksToBounds = true
        firstFloorButton.layer.cornerRadius = 5
        firstFloorButton.layer.borderWidth = 1
        firstFloorButton.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        secondFloorButton.layer.masksToBounds = true
        secondFloorButton.layer.cornerRadius = 5
        secondFloorButton.layer.borderWidth = 1
        secondFloorButton.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        setBackground(color1: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), color2: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: firstFloorButton, and: secondFloorButton)
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let imageViewSize = mapView.frame.size
        let scrollViewSize = scrollView.bounds.size
        let verticalPadding = imageViewSize.height < scrollViewSize.height ?
            (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ?
            (scrollViewSize.width - imageViewSize.width) / 2 : 0
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding,
                                               bottom: verticalPadding, right: horizontalPadding)
    }
}
