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
    
    func showLoading(_ status: Bool) {
        if status {
            ALLoadingView.manager.messageText = ""
            ALLoadingView.manager.animationDuration = 1.0
            ALLoadingView.manager.showLoadingView(ofType: .messageWithIndicator)
        } else {
            ALLoadingView.manager.hideLoadingView()
        }
    }
}
