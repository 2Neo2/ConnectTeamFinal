//
//  CustomFilterView.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 04.03.2024.
//

import UIKit

protocol CustomFilterViewDelegate: AnyObject {
    func changeContentType(with type: GameListType)
    func changeContentByFilter()
}

final class CustomFilterView: UIView {
    private lazy var personalButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Мои", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(personalButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var separator = SeparatorView()
    private var  separatorLeadingConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var  separatorWidthConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    private lazy var joinedButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Учавствую", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(joinedButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var filterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Constants.Images.filterIcon, for: .normal)
        button.imageView?.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: CustomFilterViewDelegate?
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        insertViews()
        setupView()
        layoutView()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        insertViews()
        setupView()
        layoutView()
    }
    
    @objc private func joinedButtonTapped(sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.separatorLeadingConstraint.constant = self.joinedButton.frame.origin.x - 6
            self.separatorWidthConstraint.constant = self.joinedButton.frame.width - 33
            self.layoutIfNeeded()
        }
        let type = GameListType.joined
        delegate?.changeContentType(with: type)
    }
    
    @objc private func personalButtonTapped(sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.separatorLeadingConstraint.constant = self.personalButton.frame.origin.x - 6
            self.separatorWidthConstraint.constant = self.personalButton.frame.width - 33
            self.layoutIfNeeded()
        }
        let type = GameListType.personal
        delegate?.changeContentType(with: type)
    }
    
    @objc private func filterButtonTapped() {
        delegate?.changeContentByFilter()
    }
}

extension CustomFilterView {
    private func setupView() {
        backgroundColor = Constants.Colors.backgroundColor
        translatesAutoresizingMaskIntoConstraints = false
        separator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layoutView() {
        NSLayoutConstraint.activate ([
            personalButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            personalButton.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            
            joinedButton.leadingAnchor.constraint(equalTo: personalButton.trailingAnchor, constant: 33),
            joinedButton.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            
            filterButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            filterButton.topAnchor.constraint(equalTo: topAnchor, constant: 15)
        ])
        
        separatorLeadingConstraint = separator.leadingAnchor.constraint(equalTo: personalButton.leadingAnchor)
        separatorWidthConstraint = separator.widthAnchor.constraint(equalTo: personalButton.widthAnchor)
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 2),
            separatorWidthConstraint,
            separator.bottomAnchor.constraint(equalTo: personalButton.bottomAnchor),
            separatorLeadingConstraint
        ])
    }
    
    private func insertViews() {
        addSubview(personalButton)
        addSubview(separator)
        addSubview(joinedButton)
        addSubview(filterButton)
    }
}


