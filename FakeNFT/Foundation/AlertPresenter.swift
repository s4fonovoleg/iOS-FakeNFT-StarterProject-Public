//
//  AlertPresenter.swift
//  FakeNFT
//
//  Created by Eugene Dmitrichenko on 03.03.2024.
//

import UIKit

public protocol AlertPresenterProtocol {
    
    func presentAlert(title: String?, message: String?, actions: [UIAlertAction]?, target: UIViewController?, preferredStyle: UIAlertController.Style)
}

final class AlertPresenterProfile: AlertPresenterProtocol {
    
    static let shared = AlertPresenterProfile()
    
    private init() {}
    
    /// Функция для отображения Уведомления
    /// - Parameters:
    ///     - title: Заголовок уведомления.
    ///     - message: Сообщение уведомления
    ///     - actions: Действия (кнопки), предлагаемые в уведомлении
    ///     - target: UIViewController на котором будет отображено уведомление
    ///     - preferredStyle: Предпочтительный стиль отображения уведомления
    func presentAlert(title: String?, message: String?, actions: [UIAlertAction]?, target: UIViewController?, preferredStyle: UIAlertController.Style = .alert) {
        
        let alert = UIAlertController(title: title ?? "", message: message ?? "", preferredStyle: preferredStyle)
        
        actions?.forEach {
            alert.addAction($0)
        }
        
        target?.present(alert, animated: true)
    }
}
