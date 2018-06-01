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
    @IBOutlet var thirdFloorButton: UIButton!
    @IBOutlet var searchButton: UIButton!    
    
    var pathView: PathView!
    var pathViewIsAdded: Bool = false
    
    let dataSource = MapDataSource()
    
    @IBAction func unwindToMapVC(segue: UIStoryboardSegue) {
        if let vc = segue.source as? ModalSearchVC {
            if let fromText = vc.fromTextField.text, let toText = vc.toTextField.text {                
                dataSource.path = dataSource.findPath(in: dataSource.allNodes, from: fromText, to: toText)
                pathView.allPathNodes = dataSource.path
                if let floor = dataSource.path.first?.floor {
                    setSourceNodeFloor(sourceNodeFloor: floor)
                }
            }
        }
    }
    
    @IBAction func tapFirstFloorButton(_ sender: UIButton) {
        setButtonBackgroundsForButtons(pressedButtonIndex: 1)
        pathView.frame = mapView.bounds
        pathView.currentFloorNumber = 0
        mapView.image = dataSource.mapImages[pathView.currentFloorNumber]
    }
    
    @IBAction func tapSecondFloorButton(_ sender: UIButton) {
        setButtonBackgroundsForButtons(pressedButtonIndex: 2)
        pathView.frame = mapView.bounds
        pathView.currentFloorNumber = 1
        mapView.image = dataSource.mapImages[pathView.currentFloorNumber]
    }
    
    @IBAction func tapThirdFloorButton(_ sender: UIButton) {
        setButtonBackgroundsForButtons(pressedButtonIndex: 3)
        pathView.frame = mapView.bounds
        pathView.currentFloorNumber = 2
        mapView.image = dataSource.mapImages[pathView.currentFloorNumber]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Бизнес-центр Лэтиция"
        mapView.image = dataSource.mapImages[0]
        setButtonBackgroundsForButtons(pressedButtonIndex: 1)
        setupScrollView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollViewDidZoom(scrollView)
        
        if pathViewIsAdded == false {
            pathView = PathView(frame: mapView.bounds)
            pathView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            mapView.addSubview(pathView)
            pathViewIsAdded = true
            
            pathView.allPathNodes = dataSource.path
            if let floor = dataSource.path.first?.floor {
                setSourceNodeFloor(sourceNodeFloor: floor)
            }
        }
    }
    
    func setSourceNodeFloor(sourceNodeFloor: Int) {
        pathView.currentFloorNumber = sourceNodeFloor
        mapView.image = dataSource.mapImages[sourceNodeFloor]
        switch sourceNodeFloor {
        case 0: setButtonBackgroundsForButtons(pressedButtonIndex: 1)
        case 1: setButtonBackgroundsForButtons(pressedButtonIndex: 2)
        case 2: setButtonBackgroundsForButtons(pressedButtonIndex: 3)
        default:
            setButtonBackgroundsForButtons(pressedButtonIndex: 1)
        }
    }
    
    func setupScrollView() {
        scrollView.minimumZoomScale = 0.65
        scrollView.zoomScale = scrollView.minimumZoomScale
        scrollView.contentSize = mapView.frame.size
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mapView
    }
    
    func setButtonBackgroundsForButtons(pressedButtonIndex: Int) {
        var notPressed: [UIButton] = [firstFloorButton, secondFloorButton, thirdFloorButton]
        for button in notPressed {
            button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        notPressed[pressedButtonIndex - 1].backgroundColor = #colorLiteral(red: 0, green: 0.1826862782, blue: 0.7505155457, alpha: 1)
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
