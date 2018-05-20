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
    
    @IBOutlet var fromTextField: UITextField!
    @IBOutlet var toTextField: UITextField!
    @IBAction func tapGoButton(_ sender: UIButton) {
        if let from = fromTextField.text, from != "", let to = toTextField.text, to != "" {
            dataSource.path = dataSource.findPath(in: dataSource.allNodes, from: Int(from)! - 1, to: Int(to)! - 1)
            pathView.allPathNodes = dataSource.path
            if let floor = dataSource.path.first?.floor {
                setSourceNodeFloor(sourceNodeFloor: floor)
            }
            hideKeyboard()
        }
    }
    
    var pathView: PathView!
    var pathViewIsAdded: Bool = false
    
    let dataSource = MapDataSource()
    
    @IBAction func tapFirstFloorButton(_ sender: UIButton) {
        setButtonBackgrounds(pressed: firstFloorButton, notPressed: secondFloorButton)
        pathView.frame = mapView.bounds
        pathView.currentFloorNumber = 0
        mapView.image = dataSource.mapImages[pathView.currentFloorNumber]
    }
    
    @IBAction func tapSecondFloorButton(_ sender: UIButton) {
        setButtonBackgrounds(pressed: secondFloorButton, notPressed: firstFloorButton)
        pathView.frame = mapView.bounds
        pathView.currentFloorNumber = 1
        mapView.image = dataSource.mapImages[pathView.currentFloorNumber]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Map.title".localized
        mapView.image = dataSource.mapImages[0]
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
            
            let tapGesture = UIGestureRecognizer(target: self, action: #selector(hideKeyboard))
            scrollView.addGestureRecognizer(tapGesture)
            pathView.allPathNodes = dataSource.path
            if let floor = dataSource.path.first?.floor {
                setSourceNodeFloor(sourceNodeFloor: floor)
            }
        }
    }
    
    @objc
    func hideKeyboard() {
        scrollView.endEditing(true)
    }
    
    func setSourceNodeFloor(sourceNodeFloor: Int) {
        //        let sourceNodeFloor = dataSource.path[0].floor
        pathView.currentFloorNumber = sourceNodeFloor
        mapView.image = dataSource.mapImages[sourceNodeFloor]
        sourceNodeFloor == 0
            ? setButtonBackgrounds(pressed: firstFloorButton, notPressed: secondFloorButton)
            : setButtonBackgrounds(pressed: secondFloorButton, notPressed: firstFloorButton)
    }
    
    func setupScrollView() {
        scrollView.minimumZoomScale = 0.3
        scrollView.zoomScale = scrollView.minimumZoomScale
        scrollView.contentSize = mapView.frame.size
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mapView
    }
    
    func setButtonBackgrounds(pressed: UIButton, notPressed: UIButton) {
        pressed.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        notPressed.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
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
