//
//  ViewControllerPresenter.swift
//  TestAllRight
//
//  Created by macOS on 07.03.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import UIKit

protocol ViewControllerProtocol : class {
    func addLine (line : CAShapeLayer)
    func checkAnswer ()
    func seeAnswer ()
    func removeLines (index : Int)
    func restart ()
    func tryAgain ()
    func showCongrats ()
    func showFail ()
    func showIsNotAll ()
}

let defaultLine = "line"

class ViewControllerPresenter: NSObject {
    
    weak var viewController: ViewController?
    weak var delegate: ViewControllerProtocol?
    
    // MARK: Variables
    let content = Content()
    
    private var questionCell : QuestionCell?
    private var answerCell : AnswerCell?
    
    private var firstIndexPath : IndexPath?
    private var secondIndexPath : IndexPath?
    
    private var pairs : [Pair] = []
    private var lines : [CAShapeLayer] = []
    
    // MARK: Works with table views
    func addLine (tableView : UITableView, indexPath : IndexPath) {
        if tableView == viewController?.questionTableView {
            self.firstIndexPath = indexPath
            self.questionCell = tableView.cellForRow(at: indexPath) as? QuestionCell
            guard self.answerCell == nil else {
                self.add(pair: Pair(value: self.answerCell!.answerLabel.text!, image: self.questionCell!.questionImage.image!))
                return
            }
        } else {
            self.answerCell = tableView.cellForRow(at: indexPath) as? AnswerCell
            self.secondIndexPath = indexPath
            guard self.questionCell == nil else {
                self.add(pair: Pair(value: self.answerCell!.answerLabel.text!, image: self.questionCell!.questionImage.image!))
                return
            }
        }
    }
    
    private func add (pair : Pair) {
        if !self.findFinishedPairs(from: pair) {
            self.addLine(fromPoint: self.getPoint(tableView: (viewController?.answersTableView)!, positionFrom: self.secondIndexPath!, isFirst:false), toPoint: self.getPoint(tableView: (viewController?.questionTableView)!, positionFrom: self.firstIndexPath!, isFirst:true), color: UIColor.gray)
            pairs.append(pair)
            self.clearPropirties()
        }
    }

    private func findFinishedPairs (from pair : Pair) -> Bool {
        var isFind = false
        for thisPair in pairs {
            if thisPair.value == pair.value || thisPair.image == pair.image {
                isFind = true
                break
            }
        }
        return isFind
    }
    
    private func clearPropirties () {
        self.questionCell = nil
        self.answerCell = nil
    }
    
    // MARK: Buisness logick
    func checkAnswer () {
        for (index, myPair) in pairs.enumerated() {
            let line = lines[index]
            for acceptPairs in content.aceptedPairs {
                if acceptPairs == myPair {
                    line.strokeColor = UIColor.green.cgColor
                    line.name = Color.green.description
                    break
                } else {
                    line.strokeColor = UIColor.red.cgColor
                    line.name = Color.red.description
                }
            }
        }
        self.delegate?.checkAnswer()
        self.checkAcceptValues()
    }
    
    private func checkAcceptValues () {
        if self.pairs.count == content.aceptedPairs.count {
            let sortedPairs = self.pairs.sorted { ($0.value, $1.value) < ($1.value, $0.value) }
            let sortedAceptPairs = self.pairs.sorted { ($0.value, $1.value) < ($1.value, $0.value) }
            let mainArray = sortedPairs.filter { i in sortedAceptPairs.contains{ i.value == $0.value &&  i.image == $0.image} }
            if mainArray.count == content.aceptedPairs.count {
                self.delegate?.showCongrats()
            } else {
                self.delegate?.showFail()
            }
        } else {
            self.delegate?.showIsNotAll()
        }
    }
    
    
    func seeAnswers (firstTableView : UITableView, secondTableView : UITableView ) {
        for (index, acceptPairs) in content.aceptedPairs.enumerated() {
            let firstCell = firstTableView.cellForRow(at: IndexPath(row: index, section: 0)) as! QuestionCell
            let firstPoint = self.getPoint(tableView: firstTableView, positionFrom: IndexPath(row: index, section: 0), isFirst: true)
            let cells = secondTableView.visibleCells
            for (index, _) in cells.enumerated() {
                let secondCell = secondTableView.cellForRow(at: IndexPath(row: index, section: 0)) as! AnswerCell
                
                let pair = Pair(value: secondCell.answerLabel.text!, image: firstCell.questionImage.image!)
                
                if pair.image == acceptPairs.image && acceptPairs.value == pair.value {
                    let secondPoint = self.getPoint(tableView: secondTableView, positionFrom: IndexPath(row: index, section: 0), isFirst: false)
                    
                    self.addLine(fromPoint: firstPoint, toPoint: secondPoint, color: UIColor.yellow)
                }
            }
        }
        self.delegate?.seeAnswer()
    }
    
    func removeLines (withGreen green : Bool) {
        if let layers = viewController?.view.layer.sublayers {
            for (index , layer) in layers.enumerated().reversed() {
                if layer.name == defaultLine || layer.name == Color.red.description || layer.name == Color.gray.description {
                    self.delegate?.removeLines(index: index)
                }
                if green {
                    if layer.name == Color.green.description {
                        self.delegate?.removeLines(index: index)
                    }
                }
            }
        }
    }
    
    func removeRedPairs () {
        for (index, myPair) in pairs.enumerated().reversed() {
            for acceptPairs in content.aceptedPairs {
                if !(acceptPairs == myPair) {
                    lines.remove(at: index)
                    pairs.remove(at: index)
                    self.removeLines(withGreen: false)
                    break
                }
            }
        }
        self.clear()
    }
    
    func restart () {
        self.pairs.removeAll()
        self.lines.removeAll()
        self.removeLines(withGreen: true)
        self.clear()
        self.delegate?.restart()
    }
    
    private func clear () {
        self.questionCell = nil
        self.answerCell = nil
        self.firstIndexPath = nil
        self.secondIndexPath = nil
    }
    
    private func getPoint (tableView : UITableView, positionFrom : IndexPath, isFirst : Bool) -> CGPoint {
        let rec = tableView.rectForRow(at: positionFrom)
        let position = tableView.convert(rec, to: tableView.superview)
        var point = CGPoint()
        if isFirst {
            point = CGPoint(x: position.maxX, y: position.midY)
        } else {
            point = CGPoint(x: position.minX, y: position.midY)
        }
        
        return point
    }
    
    private func addLine(fromPoint start: CGPoint, toPoint end:CGPoint, color : UIColor) {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.strokeColor = color.cgColor
        line.lineWidth = 1
        line.lineJoin = CAShapeLayerLineJoin.round
        line.name = defaultLine
        self.lines.append(line)
        self.delegate?.addLine(line: line)
    }
}
