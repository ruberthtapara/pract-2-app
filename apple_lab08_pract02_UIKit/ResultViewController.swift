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

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let cardView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayData()
    }

    private func setupUI() {
        title = "Result"
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        // Card View
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

        // Title: Calculation Result
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Calculation Result"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        cardView.addSubview(titleLabel)

        // Operation row
        let opTitleLabel = UILabel()
        opTitleLabel.text = "Operation:"
        opTitleLabel.font = UIFont.systemFont(ofSize: 16)
        opTitleLabel.textColor = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1.0)

        let opValueLabel = UILabel()
        opValueLabel.tag = 101
        opValueLabel.text = operationName
        opValueLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        opValueLabel.textColor = .black
        opValueLabel.textAlignment = .right

        let opStack = UIStackView(arrangedSubviews: [opTitleLabel, opValueLabel])
        opStack.translatesAutoresizingMaskIntoConstraints = false
        opStack.distribution = .fillEqually
        cardView.addSubview(opStack)

        // First Number row
        let firstTitleLabel = UILabel()
        firstTitleLabel.text = "First Number:"
        firstTitleLabel.font = UIFont.systemFont(ofSize: 16)
        firstTitleLabel.textColor = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1.0)

        let firstValueLabel = UILabel()
        firstValueLabel.tag = 102
        firstValueLabel.text = formatNumber(firstNumber)
        firstValueLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        firstValueLabel.textColor = .black
        firstValueLabel.textAlignment = .right

        let firstStack = UIStackView(arrangedSubviews: [firstTitleLabel, firstValueLabel])
        firstStack.translatesAutoresizingMaskIntoConstraints = false
        firstStack.distribution = .fillEqually
        cardView.addSubview(firstStack)

        // Second Number row
        let secondTitleLabel = UILabel()
        secondTitleLabel.text = "Second Number:"
        secondTitleLabel.font = UIFont.systemFont(ofSize: 16)
        secondTitleLabel.textColor = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1.0)

        let secondValueLabel = UILabel()
        secondValueLabel.tag = 103
        secondValueLabel.text = formatNumber(secondNumber)
        secondValueLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        secondValueLabel.textColor = .black
        secondValueLabel.textAlignment = .right

        let secondStack = UIStackView(arrangedSubviews: [secondTitleLabel, secondValueLabel])
        secondStack.translatesAutoresizingMaskIntoConstraints = false
        secondStack.distribution = .fillEqually
        cardView.addSubview(secondStack)

        // Divider
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1.0)
        cardView.addSubview(divider)

        // Result title label
        let resultLabelTitle = UILabel()
        resultLabelTitle.translatesAutoresizingMaskIntoConstraints = false
        resultLabelTitle.text = "Result:"
        resultLabelTitle.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        resultLabelTitle.textColor = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1.0)
        cardView.addSubview(resultLabelTitle)

        // Result Box
        let resultBox = UIView()
        resultBox.translatesAutoresizingMaskIntoConstraints = false
        resultBox.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
        resultBox.layer.cornerRadius = 10
        cardView.addSubview(resultBox)

        let resultValueLabel = UILabel()
        resultValueLabel.tag = 104
        resultValueLabel.translatesAutoresizingMaskIntoConstraints = false
        resultValueLabel.text = formatNumber(resultValue)
        resultValueLabel.font = UIFont.systemFont(ofSize: 38, weight: .bold)
        resultValueLabel.textColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
        resultValueLabel.textAlignment = .center
        resultBox.addSubview(resultValueLabel)

        // Buttons Stack
        let shareButton = UIButton(type: .system)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.setTitle("Share", for: .normal)
        shareButton.setTitleColor(.white, for: .normal)
        shareButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        shareButton.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
        shareButton.layer.cornerRadius = 20
        shareButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)

        let newCalcButton = UIButton(type: .system)
        newCalcButton.translatesAutoresizingMaskIntoConstraints = false
        newCalcButton.setTitle("New Calculation", for: .normal)
        newCalcButton.setTitleColor(UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0), for: .normal)
        newCalcButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        newCalcButton.backgroundColor = .white
        newCalcButton.layer.cornerRadius = 20
        newCalcButton.layer.borderWidth = 2
        newCalcButton.layer.borderColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0).cgColor
        newCalcButton.addTarget(self, action: #selector(didTapNewCalculation), for: .touchUpInside)

        let buttonStack = UIStackView(arrangedSubviews: [shareButton, newCalcButton])
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.axis = .horizontal
        buttonStack.spacing = 12
        buttonStack.distribution = .fillEqually
        cardView.addSubview(buttonStack)

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

            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),

            opStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 28),
            opStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            opStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            opStack.heightAnchor.constraint(equalToConstant: 26),

            firstStack.topAnchor.constraint(equalTo: opStack.bottomAnchor, constant: 14),
            firstStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            firstStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            firstStack.heightAnchor.constraint(equalToConstant: 26),

            secondStack.topAnchor.constraint(equalTo: firstStack.bottomAnchor, constant: 14),
            secondStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            secondStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            secondStack.heightAnchor.constraint(equalToConstant: 26),

            divider.topAnchor.constraint(equalTo: secondStack.bottomAnchor, constant: 20),
            divider.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            divider.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            divider.heightAnchor.constraint(equalToConstant: 1),

            resultLabelTitle.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 20),
            resultLabelTitle.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),

            resultBox.topAnchor.constraint(equalTo: resultLabelTitle.bottomAnchor, constant: 12),
            resultBox.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            resultBox.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            resultBox.heightAnchor.constraint(equalToConstant: 80),

            resultValueLabel.centerXAnchor.constraint(equalTo: resultBox.centerXAnchor),
            resultValueLabel.centerYAnchor.constraint(equalTo: resultBox.centerYAnchor),

            buttonStack.topAnchor.constraint(equalTo: resultBox.bottomAnchor, constant: 24),
            buttonStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            buttonStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            buttonStack.heightAnchor.constraint(equalToConstant: 44),
            buttonStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -24)
        ])
    }

    private func displayData() {
        if let opLabel = cardView.viewWithTag(101) as? UILabel {
            opLabel.text = operationName
        }
        if let fLabel = cardView.viewWithTag(102) as? UILabel {
            fLabel.text = formatNumber(firstNumber)
        }
        if let sLabel = cardView.viewWithTag(103) as? UILabel {
            sLabel.text = formatNumber(secondNumber)
        }
        if let rLabel = cardView.viewWithTag(104) as? UILabel {
            rLabel.text = formatNumber(resultValue)
        }
    }

    private func formatNumber(_ num: Double) -> String {
        if num.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", num)
        } else {
            return String(format: "%.2f", num)
        }
    }

    @objc private func didTapShare() {
        let textToShare = "Resultado: \(formatNumber(firstNumber)) y \(formatNumber(secondNumber)) (\(operationName)) = \(formatNumber(resultValue))"
        let activityVC = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        present(activityVC, animated: true)
    }

    @objc private func didTapNewCalculation() {
        navigationController?.popViewController(animated: true)
    }
}
