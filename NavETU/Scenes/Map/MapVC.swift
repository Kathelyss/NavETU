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
    @IBOutlet var clearRouteButton: UIButton!
    
    var pathView: PathView!
    var pathViewIsAdded: Bool = false
    
    let dataSource = MapDataSource()
    
    @IBAction func unwindToMapVC(segue: UIStoryboardSegue) {
        if let vc = segue.source as? ModalSearchVC {
            if let fromText = vc.fromTextField.text, let toText = vc.toTextField.text {
                do {
                    try legalize(source: fromText, destination: toText)
                    
                    let path = try dataSource.findPath(in: dataSource.allNodes, from: fromText, to: toText)
                    dataSource.path = path
                    pathView.allPathNodes = dataSource.path
                    clearRouteButton.isHidden = false
                    if let floor = dataSource.path.first?.floor {
                        setSourceNodeFloor(sourceNodeFloor: floor - 1)
                        setPins()
                    }
                } catch NavETUError.noPathFound {
                    showErrorAlert(title: "Ошибка", message: "Невозможно построить маршрут")
                } catch NavETUError.noSourceNode {
                    showErrorAlert(title: "Ошибка", message: "Пункт отправления не найден.\nПроверьте номер помещения!")
                } catch NavETUError.noDestinationNode {
                    showErrorAlert(title: "Ошибка", message: "Пункт назначения не найден.\nПроверьте номер помещения!")
                } catch {
                    showErrorAlert(title: "Ошибка", message: "Что-то пошло не так 😕")
                }
            }
        }
    }
    
    @IBAction func tapFloorButton(_ sender: UIButton) {
        guard let text = sender.titleLabel?.text, let number = Int(text) else { return }
        setButtonBackgroundsForButtons(pressedButtonIndex: number)
        mapView.image = dataSource.mapImages[number - 1]
        pathView.frame = mapView.bounds
        pathView.currentFloorNumber = number - 1
        setPins()
        lastTappedButton = sender
    }
    
    func legalize(source: String, destination: String) throws {
        let legalNames = ["вход", "вход2", "вход3", "балкон", "лифт1", "лифт2", "лифт3"]
        if !legalNames.contains(source),
            let sourceNumber = Int(source),
            (sourceNumber < 101 || sourceNumber > 115) &&
            (sourceNumber < 201 || sourceNumber > 215) &&
            (sourceNumber < 301 || sourceNumber > 318) {
            throw NavETUError.noSourceNode
        }
        if !legalNames.contains(destination),
            let destNumber = Int(destination),
            (destNumber < 101 || destNumber > 115) &&
            (destNumber < 201 || destNumber > 215) &&
            (destNumber < 301 || destNumber > 318) {
            throw NavETUError.noDestinationNode
        }
        
    }
    
    func showErrorAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        ac.addAction(cancel)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.present(ac, animated: true, completion: nil)
        }
    }
    
    func setPins() {
        if let startNodeForCurrentFloor = pathView.nodes.first, let pathStartNode = pathView.allPathNodes.first,
            startNodeForCurrentFloor == pathStartNode {
            pathView.startView.center = pathView.getCoordinates(for: pathStartNode)
            pathView.startView.isHidden = false
        } else {
            pathView.startView.isHidden = true
        }
        if let lastNodeForCurrentFloor = pathView.nodes.last, let pathEndNode = pathView.allPathNodes.last,
            lastNodeForCurrentFloor == pathEndNode {
            pathView.endView.center = pathView.getCoordinates(for: pathEndNode)
            pathView.endView.isHidden = false
        } else {
            pathView.endView.isHidden = true
        }
    }
    
    var lastTappedButton: UIButton?
    
    @IBAction func tapClearRouteButton(_ sender: UIButton) {
        dataSource.path.removeAll()
        pathView.allPathNodes = dataSource.path
        guard let button = lastTappedButton else {
            return
        }
        
        pathView.startView.isHidden = true
        pathView.endView.isHidden = true
        tapFloorButton(button)
        clearRouteButton.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Бизнес-центр Лэтиция"
        mapView.image = dataSource.mapImages[0]
        setButtonBackgroundsForButtons(pressedButtonIndex: 1)
        setupScrollView()
        clearRouteButton.isHidden = true
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
                setSourceNodeFloor(sourceNodeFloor: floor - 1)
            }
        }
    }
    
    func setSourceNodeFloor(sourceNodeFloor: Int) {
        mapView.image = dataSource.mapImages[sourceNodeFloor]
        pathView.frame = mapView.bounds
        pathView.currentFloorNumber = sourceNodeFloor
        setButtonBackgroundsForButtons(pressedButtonIndex: sourceNodeFloor + 1)
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
        lastTappedButton = notPressed[pressedButtonIndex - 1]
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
