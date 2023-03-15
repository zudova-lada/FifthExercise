//
//  ViewController.swift
//  FifthExercise
//
//  Created by Лада Зудова on 13.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Present", for: .normal)
        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(button)
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        button.addTarget(self, action: #selector(presentPopover), for: .touchUpInside)
    }

    @objc
    private func presentPopover() {
        let vc = PopoverViewController()
//        vc.preferredContentSize = CGSize(width: 300, height: 280)
        vc.modalPresentationStyle = .popover
        if let pres = vc.presentationController {
               pres.delegate = self
           }
        if let pop = vc.popoverPresentationController {
            pop.sourceView = button
            pop.permittedArrowDirections = .up
            pop.sourceRect = button.bounds
        }
        
        present(vc, animated: true)
    }

}

extension ViewController: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

final class PopoverViewController: UIViewController {
    
    private lazy var segmentControl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["280pt", "150pt"])
        view.translatesAutoresizingMaskIntoConstraints = false
        preferredContentSize = CGSize(width: 300, height: 280)
        view.selectedSegmentIndex = 0
        return view
    }()
    
    private lazy var button: UIButton = {
        let view = UIButton()
        let image = UIImage(systemName: "multiply.circle")?.applyingSymbolConfiguration(.init(scale: .large))
        view.setImage(image, for: .normal)
        view.scalesLargeContentImage = true
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(segmentControl)
        view.addSubview(button)

        NSLayoutConstraint.activate([
            segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentControl.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,constant: 10),
            
            button.widthAnchor.constraint(equalToConstant: 40),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 2),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2)
        ])
        
        segmentControl.addTarget(self, action: #selector(changeSegment), for: .valueChanged)
        button.addTarget(self, action: #selector(closeControl), for: .touchUpInside)
    }
    
    @objc
    private func changeSegment() {
        if segmentControl.selectedSegmentIndex == 0 {
            preferredContentSize = CGSize(width: 300, height: 280)
        } else {
            preferredContentSize = CGSize(width: 300, height: 150)
        }
    }
    
    @objc
    private func closeControl() {
        dismiss(animated: true)
    }
}
