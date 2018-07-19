//
//  ThemeService.swift
//  Chat App
//
//  Created by Suren Gevorkyan on 7/3/18.
//  Copyright © 2018 Suren Gevorkyan. All rights reserved.
//

import Foundation
import ALLoadingView

class ThemeService {
    
    func showLoading(_ status: Bool, _ message: String = "") {
        if status {
            ALLoadingView.manager.messageText = message
            ALLoadingView.manager.animationDuration = 0.5
            ALLoadingView.manager.showLoadingView(ofType: .messageWithIndicator)
        } else {
            ALLoadingView.manager.hideLoadingView()
        }
    }
}
