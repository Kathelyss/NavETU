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
    var pathView: PathView!
    var pathViewIsAdded: Bool = false
    
    @IBAction func tapFirstFloorButton(_ sender: UIButton) {
        setBackground(color1: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), color2: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: firstFloorButton, and: secondFloorButton)
        mapView.image = #imageLiteral(resourceName: "floor1")
        pathView.frame = mapView.bounds
    }
    
    @IBAction func tapSecondFloorButton(_ sender: UIButton) {
        setBackground(color1: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), color2: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: firstFloorButton, and: secondFloorButton)
        mapView.image = #imageLiteral(resourceName: "floor2")
        pathView.frame = mapView.bounds
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
        firstFloorButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        findPath(between: 16, and: 4)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollViewDidZoom(scrollView)

        pathView = PathView(frame: mapView.bounds)
        pathView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        if pathViewIsAdded == false {
            mapView.addSubview(pathView)
            pathViewIsAdded = true
        }
        pathView.setNeedsDisplay()
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
