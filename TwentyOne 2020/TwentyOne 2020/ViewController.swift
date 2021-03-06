//
//  ViewController.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 11/13/20.
//

import UIKit

protocol PairDelegate: class {
    func endMatch(leftSideWon: Bool)
}

class ViewController: UIViewController {

    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var leftLeftLabel: UILabel!
    @IBOutlet weak var leftCenterLabel: UILabel!
    @IBOutlet weak var leftRightLabel: UILabel!
    @IBOutlet weak var rightRightLabel: UILabel!
    @IBOutlet weak var rightCenterLabel: UILabel!
    @IBOutlet weak var rightLeftLabel: UILabel!
    @IBOutlet weak var leftScoreLabel: UILabel!
    @IBOutlet weak var rightScoreLabel: UILabel!

    var currentMatch: Match?

    var pairOne: Pair?
    var pairTwo: Pair?
    var pairThree: Pair?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func startMatch(_ sender: UIButton) {
        sender.isHidden = true

        let leftLeftPlayer = Player()
        let leftCenterPlayer = Player()
        let leftRightPlayer = Player()
        let rightRightPlayer = Player()
        let rightCenterPlayer = Player()
        let rightLeftPlayer = Player()

        let pairOneUi = PairUI(leftLabel: leftLeftLabel,
                               rightLabel: rightRightLabel,
                               leftScore: leftScoreLabel,
                               rightScore: rightScoreLabel)

        pairOne = Pair(leftPlayer: leftLeftPlayer,
                           rightPlayer: rightRightPlayer,
                           ballState: .leftPlayer,
                           ui: pairOneUi,
                           delegate: self)


        let pairTwoUi = PairUI(leftLabel: leftCenterLabel,
                               rightLabel: rightCenterLabel,
                               leftScore: leftScoreLabel,
                               rightScore: rightScoreLabel)

        pairTwo = Pair(leftPlayer: leftCenterPlayer,
                           rightPlayer: rightCenterPlayer,
                           ballState: .rightPlayer,
                           ui: pairTwoUi,
                           delegate: self)

        let pairThreeUi = PairUI(leftLabel: leftRightLabel,
                               rightLabel: rightLeftLabel,
                               leftScore: leftScoreLabel,
                               rightScore: rightScoreLabel)

        pairThree = Pair(leftPlayer: leftRightPlayer,
                             rightPlayer: rightLeftPlayer,
                             ballState: .leftPlayer,
                             ui: pairThreeUi,
                             delegate: self)

        guard let leftPair = pairOne, let centerPair = pairTwo, let rightPair = pairThree else { return }

        currentMatch = Match(leftPair: leftPair, centerPair: centerPair, rightPair: rightPair)

        leftLeftLabel.text = "HAS BALL"
        leftCenterLabel.text = "WAITING"
        leftRightLabel.text = "HAS BALL"
        rightRightLabel.text = "WAITING"
        rightCenterLabel.text = "HAS BALL"
        rightLeftLabel.text = "WAITING"

        leftLeftLabel.isHidden = false
        leftCenterLabel.isHidden = false
        leftRightLabel.isHidden = false
        rightRightLabel.isHidden = false
        rightCenterLabel.isHidden = false
        rightLeftLabel.isHidden = false
        rightScoreLabel.isHidden = false
        leftScoreLabel.isHidden = false


        pairOne?.start()
        pairTwo?.start()
        pairThree?.start()
    }
}

extension ViewController: PairDelegate {
    func endMatch(leftSideWon: Bool) {
        let winner = leftSideWon ? "LEFT" : "RIGHT"
        winnerLabel.text = "\(winner) WINS!"
        winnerLabel.isHidden = false

        pairOne?.stop()
        pairTwo?.stop()
        pairThree?.stop()
    }
}

