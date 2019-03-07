//
//  ViewController.swift
//  TestAllRight
//
//  Created by macOS on 04.03.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var presenter : ViewControllerPresenter!
    
    // MARK: IBOutlet
    @IBOutlet weak var answersTableView: UITableView!
    @IBOutlet weak var questionTableView: UITableView!
    
    @IBOutlet private weak var checkButton: UIButton!
    @IBOutlet private weak var tryAgainButton: UIButton!
    @IBOutlet private weak var seeAnswersButton: UIButton!
    @IBOutlet private weak var restartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.presenter = ViewControllerPresenter()
        self.presenter.delegate = self
        self.presenter.viewController = self
    }
    
    private func disableTabelViews () {
        self.questionTableView.isUserInteractionEnabled = false
        self.answersTableView.isUserInteractionEnabled = false
    }
    
    private func enableTabelViews () {
        self.questionTableView.isUserInteractionEnabled = true
        self.answersTableView.isUserInteractionEnabled = true
    }
    
    private func deselectAllRows () {
        self.questionTableView.deselectAllRows(animated: true)
        self.answersTableView.deselectAllRows(animated: true)
    }
    
    // MARK: Actions
    @IBAction func check (_ sender : UIButton) {
        self.presenter.checkAnswer()
    }
    
    @IBAction func tryAgain (_ sender : UIButton) {
        self.presenter.removeLines(withGreen: false)
        self.presenter.removeRedPairs()
    }
    
    @IBAction func restart (_ sender : UIButton) {
        self.presenter.restart()
    }
    
    @IBAction func seeAnswers (_ sender : UIButton) {
        self.presenter.restart()
        self.presenter.seeAnswers(firstTableView: self.questionTableView, secondTableView: self.answersTableView)
    }
}

// MARK: ViewControllerPresenterDelegate methods
extension ViewController : ViewControllerProtocol {
    func addLine (line : CAShapeLayer) {
        self.view.layer.addSublayer(line)
    }
    
    func checkAnswer () {
        self.deselectAllRows()
        self.seeAnswersButton.isEnabled = false
    }
    
    func removeLines (index : Int) {
        self.view.layer.sublayers?[index].removeFromSuperlayer()
    }
    
    func restart () {
        self.deselectAllRows()
        self.enableTabelViews()
        self.checkButton.isEnabled = true
        self.tryAgainButton.isEnabled = true
        self.seeAnswersButton.isEnabled = true
        self.restartButton.isEnabled = true
    }
    
    func seeAnswer () {
        self.disableTabelViews()
        self.deselectAllRows()
        self.checkButton.isEnabled = false
        self.tryAgainButton.isEnabled = false
    }
    
    func tryAgain () {
        self.enableTabelViews()
        self.seeAnswersButton.isEnabled = false
        self.deselectAllRows()
    }
    
    func showCongrats () {
        self.presentAlert(withTitle: "Congrats", message: "Nice  work!") {
            self.presenter.restart()
        }
    }
    
    func showFail () {
        self.presentAlert(withTitle: "Fail:(", message: "Try again") {
           self.presenter.restart()
        }
    }
    
    func showIsNotAll () {
        self.presentAlert(withTitle: "Fail:(", message: "Is not all!") {
            
        }
    }
}
