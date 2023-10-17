//
//  DeleteAccountDetailsViewController.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 07/06/2023.
//  
//

import UIKit

class DeleteAccountDetailsViewController: BaseViewController {
        
    // MARK: Outlets
    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var deleteButton: BaseButton!
    @IBOutlet private weak var cancelButton: BaseButton!
    // MARK: Properties

    var presenter: DeleteAccountDetailsPresenterProtocol?
    weak var delegate: DeleteAccountDetailsViewDelegate?
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setUI()
    }
    
    private func setUI() {
        setFonts()
    }
    
    private func setFonts() {
        titleLabel.font = AppFont.appSemiBold(size: .h7)
        subtitleLabel.font = AppFont.appRegular(size: .body4)
        deleteButton.titleLabel?.font = AppFont.appSemiBold(size: .body3)
        cancelButton.titleLabel?.font = AppFont.appSemiBold(size: .body3)
    }
    
    // MARK: - Actions

    @IBAction func closeButtonTapped(_ sender: Any) {
        delegate?.didTapCloseButton()
    }
    @IBAction func deleteButtonTapped(_ sender: Any) {
        delegate?.didTapDeleteButton()
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        delegate?.didTapCancelButton()
    }
}

extension DeleteAccountDetailsViewController: DeleteAccountDetailsViewProtocol {
    
    func setIconImage(title: String) {
        iconImage.image = UIImage(named: title)
    }
    func setTitleLabel(title: String) {
        titleLabel.text = title
    }
    func setSubtitleLabel(title: String) {
        subtitleLabel.text = title
    }
    func setDeleteButton(title: String) {
        deleteButton.setTitle(title, for: .normal)
    }
    func setCancelButton(title: String) {
        cancelButton.setTitle(title, for: .normal)
    }
}
