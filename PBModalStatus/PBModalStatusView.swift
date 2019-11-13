//
//  PBModalStatusView.swift
//  PBModalStatus
//
//  Created by Prakhar Prakash Bhardwaj on 13/11/19.
//  Copyright © 2019 Prakhar Prakash Bhardwaj. All rights reserved.
//

import UIKit

public class PBModalStatusView: UIView {
    
    @IBOutlet private weak var statusImage: UIImageView!
    @IBOutlet private weak var headlineLabel: UILabel!
    @IBOutlet private weak var subheadLabel: UILabel!
    
    let nibName = "PBModalStatusView"
    var contentView: UIView!
    var timer: Timer?
    
    //MARK: Set Up View
    
    public override func didMoveToSuperview() {
        //Fade in when added to superview
        //Then add a timer to remove the view
        self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.15, animations: {
            self.contentView.alpha = 1.0
            self.contentView.transform = CGAffineTransform.identity
        }) { _ in self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(3.0), target: self, selector: #selector(self.removeSelf), userInfo: nil, repeats: false)
        }
    }
    
    public override func layoutSubviews() {
        self.layoutIfNeeded()
        self.contentView.layer.masksToBounds = true
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 10
    }
    
    public override init(frame: CGRect) {
        // For use in code
        super.init(frame: frame)
        setUpView()
    }
    
    public required init?(coder: NSCoder) {
        // For use in IB
        super.init(coder: coder)
        setUpView()
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        self.contentView = (nib.instantiate(withOwner: self, options: nil).first as! UIView)
        addSubview(self.contentView)
        contentView.center = self.center
        contentView.autoresizingMask = []
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        headlineLabel.text = ""
        subheadLabel.text = ""
    }
    
    //Provide func to update view
    public func set(image: UIImage){
        self.statusImage.image = image
    }
    
    public func set(headline: String){
        self.headlineLabel.text = headline
    }
    
    public func set(subhead: String){
        self.subheadLabel.text = subhead
    }
    
    @objc private func removeSelf() {
        // Animate removal of view
        UIView.animate(
            withDuration: 0.15,
            animations: {
                self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.contentView.alpha = 0.0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}
