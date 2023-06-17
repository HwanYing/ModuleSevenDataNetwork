//
//  RatingControl.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/4/4.
//

import UIKit

@IBDesignable
class RatingControl: UIStackView {
    
    @IBInspectable var starSize: CGSize = CGSize(width: 14.0, height: 14.0) {
        didSet {
            setUpButtons()
            updateRatingButtons()
        }
    }
    
    @IBInspectable var starCount : Int = 5 {
        didSet {
            setUpButtons()
            updateRatingButtons()
        }
    }
    @IBInspectable var rating: Int = 3 {
        didSet {
            updateRatingButtons()
        }
    }
    var ratingButtons = [UIButton]()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButtons()
        updateRatingButtons()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - UI Setup
    
    override func prepareForInterfaceBuilder() {
        setUpButtons()
        updateRatingButtons()
    }
    private func setUpButtons() {
        
        clearExistingButtons()
        
        for _ in 0..<starCount {
            
            let button = UIButton()
            
            button.setImage(UIImage(named: "filledStar"), for: .selected)
            button.setImage(UIImage(named: "emptyStar"), for: .normal)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            addArrangedSubview(button)
            button.isUserInteractionEnabled = false
            ratingButtons.append(button)
        }
    }
    private func updateRatingButtons() {
        for(index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
    private func clearExistingButtons() {
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
    }
}
