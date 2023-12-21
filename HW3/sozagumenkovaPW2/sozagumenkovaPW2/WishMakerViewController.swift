//
//  WishMakerViewController.swift
//  sozagumenkovaPW2
//
//  Created by Sonya Zagumenkova on 24.11.2023.
//

import UIKit

final class WishMakerViewController: UIViewController {
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let toggleSlidersButton = UIButton()
    private let stack = UIStackView()
    final class CustomSlider: UIView {
        var valueChanged: ((Double) -> Void)?
        
        var slider = UISlider()
        var titleView = UILabel()
        init(title: String, min: Double, max: Double) {
            super.init(frame: .zero)
            titleView.text = title
            slider.minimumValue = Float(min)
            slider.maximumValue = Float(max)
            slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
            configureUI()
            
        }
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
            
        }
        private func configureUI() {
            backgroundColor = .white
            translatesAutoresizingMaskIntoConstraints = false
            for view in [slider, titleView] {
                addSubview(view)
                view.translatesAutoresizingMaskIntoConstraints = false
                
            }
            NSLayoutConstraint.activate([
                titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
                titleView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                slider.topAnchor.constraint(equalTo: titleView.bottomAnchor),
                slider.centerXAnchor.constraint(equalTo: centerXAnchor),
                slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
                slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
            ])
            
        }
        @objc
        private func sliderValueChanged() {
            valueChanged?(Double(slider.value))
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    enum Constants {
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        static let red: String = "Red"
        static let green: String = "Green"
        static let blue: String = "Blue"
        static let buttonText: String = "Табличка"
        static let stackRadius: CGFloat = 20
        static let buttonRadius: CGFloat = 6
        static let stackBottom: CGFloat = -100
        static let ButtonBottom: CGFloat = -300
        static let ButtonTrailing: CGFloat = -20
        static let stackLeading: CGFloat = 20
        static let titleFontSize: CGFloat = 30
        static let descriptionFontSize: CGFloat = 18
        static let leadingAnchor: CGFloat = 20
        static let titleTop: CGFloat = 30
        static let descriptionTop: CGFloat = 20
        static let colorRange: CGFloat = 100
        static let buttonLeadingAnchor: CGFloat = 100
        static let addButtonHeight: CGFloat = 50
        static let addButtonBottom: CGFloat = 30
        static let buttonSide: CGFloat = 100
    }

    private func configureUI() {
        view.backgroundColor = .lightGray
        configureTitle()
        configureDescription()
        configureSliders()
        configureButton()
        configureAddWishButton()
    }

    private func configureButton() {
        toggleSlidersButton.translatesAutoresizingMaskIntoConstraints = false
        toggleSlidersButton.setTitle("Слайдер", for: .normal)
        toggleSlidersButton.backgroundColor = .white
        toggleSlidersButton.layer.cornerRadius = Constants.buttonRadius
        toggleSlidersButton.setTitleColor(.darkGray, for: .normal)
        toggleSlidersButton.addTarget(self, action: #selector(ButtonAction), for: .touchUpInside)

        view.addSubview(toggleSlidersButton)
        NSLayoutConstraint.activate([
            toggleSlidersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingAnchor),
            toggleSlidersButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -120),
            toggleSlidersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.ButtonBottom)
        ])
    }

    @objc private func ButtonAction() {
        stack.isHidden = !stack.isHidden
    }

    private func configureTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Wishmaker"
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        titleLabel.textColor = UIColor.yellow
        titleLabel.textAlignment = .center

        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.buttonLeadingAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor), // Почему-то не смогла сделать кнопочку ровно
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleTop)
        ])
    }

    private func configureDescription() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "тяни за слайдер, чтобы поменять цвет фона"
        descriptionLabel.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        descriptionLabel.textColor = UIColor.yellow
        descriptionLabel.numberOfLines = 0
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.descriptionTop)
        ])
    }
    private let addWishButton: UIButton = UIButton(type: .system)

    private func configureAddWishButton() {
        view.addSubview(addWishButton)
        addWishButton.setHeight(Constants.addButtonHeight)
        addWishButton.pinBottom(to: view, Constants.addButtonBottom)
        addWishButton.pinHorizontal(to: view, Constants.buttonSide)

        addWishButton.backgroundColor = .red
        addWishButton.setTitleColor(.white, for: .normal)
        addWishButton.setTitle(Constants.buttonText, for: .normal)

        addWishButton.layer.cornerRadius = Constants.buttonRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }

    @objc private func addWishButtonPressed() {
        present(WishStoringViewController(), animated: true)
        let wishStoringVC = WishStoringViewController()
    }



    private func configureSliders() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = Constants.stackRadius
        stack.clipsToBounds = true

        let sliderRed = CustomSlider(title: "Red", min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderBlue = CustomSlider(title: "Blue", min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderGreen = CustomSlider(title: "Green", min: Constants.sliderMin, max: Constants.sliderMax)

        for slider in [sliderRed, sliderBlue, sliderGreen] {
            stack.addArrangedSubview(slider)
            slider.valueChanged = { [weak self, sliderRed, sliderGreen, sliderBlue] _ in
                self?.changeBackgroundColor(sliderRed: sliderRed, sliderGreen: sliderGreen, sliderBlue: sliderBlue)
            }
        }

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingAnchor),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.stackBottom)
        ])
    }

    private func changeBackgroundColor(sliderRed: CustomSlider, sliderGreen: CustomSlider, sliderBlue: CustomSlider) {
        let redValue = CGFloat(sliderRed.slider.value)
        let greenValue = CGFloat(sliderGreen.slider.value)
        let blueValue = CGFloat(sliderBlue.slider.value)
        view.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }
}
