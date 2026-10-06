//
//  ResultViewController.swift
//  apple_lab08_pract02_UIKit
//

import UIKit

class ResultViewController: UIViewController {

    var operationName: String = "Addition (+)"
    var firstNumber: Double = 0
    var secondNumber: Double = 0
    var resultValue: Double = 0

    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var firstNumberLabel: UILabel!
    @IBOutlet weak var secondNumberLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var newCalculationButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Result"

        shareButton?.layer.cornerRadius = 20
        shareButton?.clipsToBounds = true

        newCalculationButton?.layer.cornerRadius = 20
        newCalculationButton?.layer.borderWidth = 2
        newCalculationButton?.layer.borderColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0).cgColor
        newCalculationButton?.clipsToBounds = true

        displayData()
    }

    private func displayData() {
        operationLabel?.text = operationName
        firstNumberLabel?.text = formatNumber(firstNumber)
        secondNumberLabel?.text = formatNumber(secondNumber)
        resultLabel?.text = formatNumber(resultValue)
    }

    private func formatNumber(_ num: Double) -> String {
        if num.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", num)
        } else {
            return String(format: "%.2f", num)
        }
    }

    @IBAction func shareTapped(_ sender: UIButton) {
        let textToShare = "Resultado: \(formatNumber(firstNumber)) y \(formatNumber(secondNumber)) (\(operationName)) = \(formatNumber(resultValue))"
        let activityVC = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        present(activityVC, animated: true)
    }

    @IBAction func newCalculationTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
