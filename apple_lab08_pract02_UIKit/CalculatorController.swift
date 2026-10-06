//
//  CalculatorController.swift
//  apple_lab08_pract02_UIKit
//

import UIKit

class CalculatorController: UIViewController {

    @IBOutlet weak var firstNumberTextField: UITextField!
    @IBOutlet weak var secondNumberTextField: UITextField!
    @IBOutlet weak var operationSegmentedControl: UISegmentedControl!
    @IBOutlet weak var calculateButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Calculator"
        calculateButton?.layer.cornerRadius = 25
        calculateButton?.clipsToBounds = true
        setupDismissKeyboard()
    }

    private func setupDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func calculateTapped(_ sender: UIButton) {
        performCalculation()
    }

    private func performCalculation() {
        let first = Double(firstNumberTextField?.text?.replacingOccurrences(of: ",", with: ".") ?? "0") ?? 0
        let second = Double(secondNumberTextField?.text?.replacingOccurrences(of: ",", with: ".") ?? "0") ?? 0

        let selectedIndex = operationSegmentedControl?.selectedSegmentIndex ?? 0
        let opName: String
        let result: Double

        switch selectedIndex {
        case 0:
            opName = "Addition (+)"
            result = first + second
        case 1:
            opName = "Subtraction (-)"
            result = first - second
        case 2:
            opName = "Multiplication (×)"
            result = first * second
        default:
            opName = "Addition (+)"
            result = first + second
        }

        performSegue(withIdentifier: "showResultSegue", sender: (opName, first, second, result))
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResultSegue",
           let destVC = segue.destination as? ResultViewController,
           let data = sender as? (String, Double, Double, Double) {
            destVC.operationName = data.0
            destVC.firstNumber = data.1
            destVC.secondNumber = data.2
            destVC.resultValue = data.3
        }
    }
}
