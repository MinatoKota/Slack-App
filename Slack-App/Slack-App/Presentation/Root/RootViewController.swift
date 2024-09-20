//
//  RootViewController.swift
//  Slack-App
//
//  Created by 湊航太 on 2024/09/20.
//

import UIKit

final class RootViewController: UIViewController {

    // MARK: - Properties

    private var currentVC: UIViewController

    // MARK: - LifeCycle

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        currentVC = SplashViewController()
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addCurrentVCAsChild()
    }
    
}

// MARK: - Private

private extension RootViewController {

    /// currentVCをRootVCの子VCとして追加
    func addCurrentVCAsChild() {
        addChild(currentVC)
        currentVC.view.frame = view.bounds
        view.addSubview(currentVC.view)
        currentVC.didMove(toParent: self)
    }

    /// RootVCの子VCを入れ替えることでルートの画面を切り替える
    func transition(to vc: UIViewController) {
        addChild(vc)
        vc.view.frame = view.bounds
        vc.view.backgroundColor = .white
        view.addSubview(vc.view)
        vc.didMove(toParent: self)
        currentVC.willMove(toParent: nil)
        currentVC.view.removeFromSuperview()
        currentVC.removeFromParent()
        currentVC = vc
    }
}
