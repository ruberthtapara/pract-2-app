//
//  CalculatorController.swift
//  apple_lab08_pract02_UIKit
//

import UIKit

class CalculatorController: UIViewController {

    enum MathOp: String, CaseIterable {
        case addition = "Addition (+)"
        case subtraction = "Subtraction (-)"
        case multiplication = "Multiplication (×)"

        func calculate(_ a: Double, _ b: Double) -> Double {
            switch self {
            case .addition: return a + b
            case .subtraction: return a - b
            case .multiplication: return a * b
            }
        }
    }

    private var selectedOp: MathOp = .addition

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let cardView = UIView()

    private let firstTextField = UITextField()
    private let secondTextField = UITextField()
    private var opButtons: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDismissKeyboard()
    }

    private func setupUI() {
        title = "Calculator"
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        // Card Container
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 12
        cardView.layer.borderColor = UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1.0).cgColor
        cardView.layer.borderWidth = 1
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.05
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 8
        contentView.addSubview(cardView)

        // Card Title: Math Operation
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Math Operation"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        cardView.addSubview(titleLabel)

        // First Number Container
        let firstBox = createInputField(title: "First Number", textField: firstTextField, defaultText: "0")
        cardView.addSubview(firstBox)

        // Second Number Container
        let secondBox = createInputField(title: "Second Number", textField: secondTextField, defaultText: "0")
        cardView.addSubview(secondBox)

        // Operation container
        let opSelectorContainer = UIView()
        opSelectorContainer.translatesAutoresizingMaskIntoConstraints = false
        opSelectorContainer.backgroundColor = .white
        opSelectorContainer.layer.cornerRadius = 8
        opSelectorContainer.layer.borderWidth = 1
        opSelectorContainer.layer.borderColor = UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1.0).cgColor
        opSelectorContainer.clipsToBounds = true
        cardView.addSubview(opSelectorContainer)

        let opHeaderLabel = UILabel()
        opHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        opHeaderLabel.text = "Operation"
        opHeaderLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        opHeaderLabel.textColor = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1.0)
        cardView.addSubview(opHeaderLabel)

        // Operation buttons inside selector container
        var previousView: UIView? = nil
        for (index, op) in MathOp.allCases.enumerated() {
            let btn = UIButton(type: .system)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle(op.rawValue, for: .normal)
            btn.contentHorizontalAlignment = .left
            btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: op == selectedOp ? .semibold : .regular)
            btn.setTitleColor(op == selectedOp ? UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0) : .black, for: .normal)
            btn.tag = index
            btn.addTarget(self, action: #selector(didSelectOperation(_:)), for: .touchUpInside)
            opButtons.append(btn)
            opSelectorContainer.addSubview(btn)

            NSLayoutConstraint.activate([
                btn.leadingAnchor.constraint(equalTo: opSelectorContainer.leadingAnchor),
                btn.trailingAnchor.constraint(equalTo: opSelectorContainer.trailingAnchor),
                btn.heightAnchor.constraint(equalToConstant: 44)
            ])

            if let prev = previousView {
                let sep = UIView()
                sep.translatesAutoresizingMaskIntoConstraints = false
                sep.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1.0)
                opSelectorContainer.addSubview(sep)

                NSLayoutConstraint.activate([
                    sep.topAnchor.constraint(equalTo: prev.bottomAnchor),
                    sep.leadingAnchor.constraint(equalTo: opSelectorContainer.leadingAnchor),
                    sep.trailingAnchor.constraint(equalTo: opSelectorContainer.trailingAnchor),
                    sep.heightAnchor.constraint(equalToConstant: 1),
                    btn.topAnchor.constraint(equalTo: sep.bottomAnchor)
                ])
            } else {
                btn.topAnchor.constraint(equalTo: opSelectorContainer.topAnchor).isActive = true
            }
            previousView = btn
        }
        previousView?.bottomAnchor.constraint(equalTo: opSelectorContainer.bottomAnchor).isActive = true

        // Calculate Button
        let calcButton = UIButton(type: .system)
        calcButton.translatesAutoresizingMaskIntoConstraints = false
        calcButton.setTitle("Calculate", for: .normal)
        calcButton.setTitleColor(.white, for: .normal)
        calcButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        calcButton.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
        calcButton.layer.cornerRadius = 25
        calcButton.addTarget(self, action: #selector(didTapCalculate), for: .touchUpInside)
        cardView.addSubview(calcButton)

        // Constraints
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),

            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),

            firstBox.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            firstBox.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            firstBox.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            firstBox.heightAnchor.constraint(equalToConstant: 64),

            secondBox.topAnchor.constraint(equalTo: firstBox.bottomAnchor, constant: 14),
            secondBox.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            secondBox.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            secondBox.heightAnchor.constraint(equalToConstant: 64),

            opHeaderLabel.topAnchor.constraint(equalTo: secondBox.bottomAnchor, constant: 16),
            opHeaderLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),

            opSelectorContainer.topAnchor.constraint(equalTo: opHeaderLabel.bottomAnchor, constant: 8),
            opSelectorContainer.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            opSelectorContainer.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),

            calcButton.topAnchor.constraint(equalTo: opSelectorContainer.bottomAnchor, constant: 24),
            calcButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            calcButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            calcButton.heightAnchor.constraint(equalToConstant: 50),
            calcButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -24)
        ])
    }

    private func createInputField(title: String, textField: UITextField, defaultText: String) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
        container.layer.cornerRadius = 8

        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        titleLabel.textColor = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1.0)
        container.addSubview(titleLabel)

        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1.0)
        container.addSubview(line)

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = defaultText
        textField.placeholder = "0"
        textField.keyboardType = .numbersAndPunctuation
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.textColor = .black
        container.addSubview(textField)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),

            line.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            line.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            line.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            line.heightAnchor.constraint(equalToConstant: 1),

            textField.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 4),
            textField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            textField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            textField.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -6)
        ])

        return container
    }

    @objc private func didSelectOperation(_ sender: UIButton) {
        guard sender.tag < MathOp.allCases.count else { return }
        selectedOp = MathOp.allCases[sender.tag]

        for (index, btn) in opButtons.enumerated() {
            if index == sender.tag {
                btn.setTitleColor(UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0), for: .normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            } else {
                btn.setTitleColor(.black, for: .normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            }
        }
    }

    @objc private func didTapCalculate() {
        let first = Double(firstTextField.text?.replacingOccurrences(of: ",", with: ".") ?? "0") ?? 0
        let second = Double(secondTextField.text?.replacingOccurrences(of: ",", with: ".") ?? "0") ?? 0
        let result = selectedOp.calculate(first, second)

        let resultVC = ResultViewController()
        resultVC.operationName = selectedOp.rawValue
        resultVC.firstNumber = first
        resultVC.secondNumber = second
        resultVC.resultValue = result

        navigationController?.pushViewController(resultVC, animated: true)
    }

    private func setupDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
