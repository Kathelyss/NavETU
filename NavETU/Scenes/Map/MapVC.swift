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
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var floorButtons: UIStackView!
    @IBOutlet var firstFloorButton: UIButton!
    @IBOutlet var secondFloorButton: UIButton!
    
    @IBAction func tapFirstFloorButton(_ sender: UIButton) {
        setBackground(color1: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), color2: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: firstFloorButton, and: secondFloorButton)
        imageView.image = #imageLiteral(resourceName: "floor1")
    }
    
    @IBAction func tapSecondFloorButton(_ sender: UIButton) {
        setBackground(color1: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), color2: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: firstFloorButton, and: secondFloorButton)
        imageView.image = #imageLiteral(resourceName: "floor2")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.frame = view.frame
        title = "Map.title".localized
        scrollView.contentSize = imageView.bounds.size
        scrollView.addSubview(imageView)
        setupFloorButtons()
        imageView.image = #imageLiteral(resourceName: "floor1")
        firstFloorButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        scrollView.delegate = self
        setZoomScale()
//        setupGestureRecognizer()
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
    
    override func viewWillLayoutSubviews() {
        setZoomScale()
    }
    
    func setZoomScale() {
        let imageViewSize = imageView.bounds.size
        let scrollViewSize = scrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        scrollView.minimumZoomScale = 0.1// min(widthScale, heightScale)
        scrollView.zoomScale = 1.0
    }

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let imageViewSize = imageView.frame.size
        let scrollViewSize = scrollView.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ?
            (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ?
            (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding,
                                               left: horizontalPadding,
                                               bottom: verticalPadding,
                                               right: horizontalPadding)
    }
    
    func setupGestureRecognizer() {
        let doubleTap = UITapGestureRecognizer(target: scrollView, action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
    }
    
    @objc
    func handleDoubleTap(recognizer: UITapGestureRecognizer) {
        if (scrollView.zoomScale > scrollView.minimumZoomScale) {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }
    }
}
