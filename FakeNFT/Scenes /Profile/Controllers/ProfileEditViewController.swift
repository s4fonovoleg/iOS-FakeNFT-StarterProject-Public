//
//  ProfileEditViewController.swift
//  FakeNFT
//
//  Created by Eugene Dmitrichenko on 20.02.2024.
//

import Combine
import Kingfisher
import UIKit

final class ProfileEditViewController: UIViewController {
    
    private var changesMade: Bool = false
    private let profileEditViewModel: ProfileEditViewModel
    private var scrollViewBottomConstraint: NSLayoutConstraint?
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var buttonClose: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNames.buttonClose), for: .normal)
        return button
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var imageViewUserPicture: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 35
        imageView.contentMode = .scaleAspectFill
        let shadow = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        shadow.backgroundColor = UIColor(named: ColorNames.lightGray)
        shadow.layer.opacity = 0.6
        imageView.clipsToBounds = true
        imageView.addSubview(shadow)
        return imageView
    }()
    
    private lazy var labelChangePicture: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.text = NSLocalizedString(LocalizableKeys.profileEditChangePicLabel, comment: "")
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(named: ColorNames.whiteUniversal)
        return label
    }()
    
    private lazy var labelDescription: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.text = NSLocalizedString(LocalizableKeys.profileEditLabelDescription, comment: "")
        return label
    }()
    
    private lazy var labelName: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.text = NSLocalizedString(LocalizableKeys.profileEditLabelName, comment: "")
        return label
    }()
    
    private lazy var labelSite: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.text = NSLocalizedString(LocalizableKeys.profileEditLabelSite, comment: "")
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var textFieldUserName: CustomTextField = {
        let field: CustomTextField = CustomTextField()
        field.placeholder = NSLocalizedString(LocalizableKeys.profileEditLabelName, comment: "")
        field.clearButtonMode = .whileEditing
        field.backgroundColor = UIColor(named: ColorNames.lightGray)
        field.layer.cornerRadius = 12
        field.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return field
    }()
    
    private lazy var textFieldChangePicture: CustomTextField = {
        let field: CustomTextField = CustomTextField()
        field.placeholder = NSLocalizedString(LocalizableKeys.profileEditChangePicURL, comment: "")
        field.clearButtonMode = .whileEditing
        field.backgroundColor = UIColor(named: ColorNames.lightGray)
        field.layer.cornerRadius = 12
        field.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        field.textAlignment = .center
        field.isHidden = true
        return field
    }()
    
    private lazy var textFieldSite: CustomTextField = {
        let field: CustomTextField = CustomTextField()
        field.placeholder = NSLocalizedString(LocalizableKeys.profileEditLabelSite, comment: "")
        field.clearButtonMode = .whileEditing
        field.backgroundColor = UIColor(named: ColorNames.lightGray)
        field.layer.cornerRadius = 12
        field.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return field
    }()
    
    private lazy var textViewDescription: UITextView = {
        let textView: UITextView = UITextView()
        textView.backgroundColor = UIColor(named: ColorNames.lightGray)
        textView.layer.cornerRadius = 12
        textView.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return textView
    }()
    
    init(profileEditViewModel: ProfileEditViewModel) {
        self.profileEditViewModel = profileEditViewModel
        super.init(nibName: nil, bundle: nil)
        
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIElements()
        setupUILayout()
        
        textFieldChangePicture.delegate = self
        textFieldSite.delegate = self
        textFieldUserName.delegate = self
        textViewDescription.delegate = self
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func setupBindings() {
        
        profileEditViewModel.$avatar.sink(receiveValue: { [weak self] avatar in
            if let self, let url = avatar, let imageUrl = URL(string: url) {
                let roundCornerEffect = RoundCornerImageProcessor(cornerRadius: 8.0)
                self.imageViewUserPicture.kf.indicatorType = .activity
                self.imageViewUserPicture.kf.setImage(with: imageUrl, options: [.processor(roundCornerEffect)])
            }
        }).store(in: &subscriptions)
        
        profileEditViewModel.$description.sink(receiveValue: { [weak self] description in
            self?.textViewDescription.text = description
        }).store(in: &subscriptions)
        
        profileEditViewModel.$name.sink(receiveValue: { [weak self] name in
            self?.textFieldUserName.text = name
        }).store(in: &subscriptions)
        
        profileEditViewModel.$website.sink(receiveValue: { [weak self] website in
            self?.textFieldSite.text = website
        }).store(in: &subscriptions)
        
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: textFieldChangePicture)
            .sink { [weak self] notification in
                guard let self, let textField = notification.object as? UITextField else { return }
                self.profileEditViewModel.newAvatar = textField.text
                changesMade = true
            }.store(in: &subscriptions)
        
        NotificationCenter.default.publisher(for: UITextView.textDidChangeNotification, object: textViewDescription)
            .sink { [weak self] notification in
                guard let self, let textView = notification.object as? UITextView else { return }
                self.profileEditViewModel.newDescription = textView.text
                changesMade = true
            }
            .store(in: &subscriptions)
        
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: textFieldUserName)
            .sink { [weak self] notification in
                guard let self, let textField = notification.object as? UITextField else { return }
                self.profileEditViewModel.newName = textField.text
                changesMade = true
            }
            .store(in: &subscriptions)
        
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: textFieldSite)
            .sink { [weak self] notification in
                guard let self, let textField = notification.object as? UITextField else { return }
                self.profileEditViewModel.newWebsite = textField.text
                changesMade = true
            }
            .store(in: &subscriptions)
        
        profileEditViewModel.alertInfo = {[weak self] (title, buttonTitle, message, shouldDismiss) in
            guard let self else { return }
            let action = UIAlertAction(title: buttonTitle, style: .cancel) { _ in
                if shouldDismiss {
                    self.dismiss(animated: true)
                } else {
                    self.buttonClose.isEnabled = true
                }
            }
            AlertPresenterProfile.shared.presentAlert(title: title, message: message, actions: [action], target: self)
        }
    }
    
    private func setupUIElements() {
        view.backgroundColor = UIColor(named: ColorNames.white)
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        [   buttonClose,
            imageViewUserPicture,
            labelChangePicture,
            labelName,
            textFieldUserName,
            labelDescription,
            textViewDescription,
            labelSite,
            textFieldSite,
            textFieldChangePicture
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        buttonClose.addTarget(self, action: #selector(buttonCloseTapped), for: .touchUpInside)
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewDidTapped)))
        
        labelChangePicture.isUserInteractionEnabled = true
        labelChangePicture.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelChangePictureToggle)))
    }
    
    private func setupUILayout() {
        
        scrollViewBottomConstraint = scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        scrollViewBottomConstraint?.constant = 0
        scrollViewBottomConstraint?.isActive = true
        
        let contentViewHeightAnchor = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        contentViewHeightAnchor.priority = UILayoutPriority(50)
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            contentViewHeightAnchor,
            
            buttonClose.heightAnchor.constraint(equalToConstant: 42),
            buttonClose.widthAnchor.constraint(equalToConstant: 42),
            buttonClose.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            buttonClose.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            imageViewUserPicture.heightAnchor.constraint(equalToConstant: 70),
            imageViewUserPicture.widthAnchor.constraint(equalToConstant: 70),
            imageViewUserPicture.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            imageViewUserPicture.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            labelChangePicture.centerYAnchor.constraint(equalTo: imageViewUserPicture.centerYAnchor),
            labelChangePicture.centerXAnchor.constraint(equalTo: imageViewUserPicture.centerXAnchor),
            
            textFieldChangePicture.heightAnchor.constraint(equalToConstant: 44),
            textFieldChangePicture.topAnchor.constraint(equalTo: imageViewUserPicture.bottomAnchor, constant: 16),
            textFieldChangePicture.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textFieldChangePicture.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            labelName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 199),
            labelName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            textFieldUserName.heightAnchor.constraint(equalToConstant: 44),
            textFieldUserName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 235),
            textFieldUserName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textFieldUserName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            labelDescription.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 303),
            labelDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            textViewDescription.heightAnchor.constraint(equalToConstant: 132),
            textViewDescription.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 339),
            textViewDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textViewDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            labelSite.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 495),
            labelSite.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            textFieldSite.heightAnchor.constraint(equalToConstant: 44),
            textFieldSite.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 531),
            textFieldSite.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textFieldSite.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textFieldSite.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    @objc
    private func buttonCloseTapped() {
        
        buttonClose.isEnabled = false
        
        if changesMade {
            profileEditViewModel.saveProfile()
        } else {
            dismiss(animated: true)
        }
    }
    
    @objc
    private func labelChangePictureToggle() {
        textFieldChangePicture.isHidden = !textFieldChangePicture.isHidden
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) {
        updateScrollView(with: 0)
    }
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            updateScrollView(with: keyboardHeight)
        }
    }
    
    private func updateScrollView(with height: CGFloat) {
        scrollViewBottomConstraint?.constant = 0 - height
        scrollView.layoutIfNeeded()
    }
    
    @objc
    private func viewDidTapped() {
        [textFieldUserName, textFieldSite, textViewDescription, textFieldChangePicture].forEach {
            $0.resignFirstResponder()
        }
        textFieldChangePicture.isHidden = true
    }
}

extension ProfileEditViewController: UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textFieldChangePicture.isHidden = true
        return true
    }
}
