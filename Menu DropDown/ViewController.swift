//
//  ViewController.swift
//  Menu DropDown
//
//  Created by Marcos Felipe Souza on 31/07/2018.
//  Copyright © 2018 Marcos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var button = BtnMenuDropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button = BtnMenuDropDown.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        button.setTitle("Color", for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        button.dropView.dropDownOption = ["Assim", "Olha"]
        
    }

}



class BtnMenuDropDown: UIButton {
    
    var dropView = DropDownView()
    var height = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .darkGray
        dropView = DropDownView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        dropView.translatesAutoresizingMaskIntoConstraints = false
       
    }
    
    override func didMoveToSuperview() {
        self.superview?.addSubview(dropView)
        self.superview?.bringSubview(toFront: dropView)
        
        dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dropView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        height = dropView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    var isOpen = false
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !isOpen {
            isOpen = true
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 150
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.layoutIfNeeded()
                self.dropView.center.y += self.dropView.frame.height / 2
            }, completion: nil)
            
        } else {
            isOpen = false
            
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.center.y -= self.dropView.frame.height / 2
                self.dropView.layoutIfNeeded()
            }, completion: nil)            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class DropDownView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var dropDownOption = [String]()
    var tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.backgroundColor = .darkGray
        self.backgroundColor = .darkGray
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dropDownOption.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dropDownOption[indexPath.row]
        cell.backgroundColor = .darkGray
        
        return cell
    }
    
    
}

