//
//  BasePageControl.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 06/04/2023.
//

import UIKit

class BasePageControl: UIView {

    @IBOutlet weak var mainView: UIView!
    var view:UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }

    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()

    }
    private func commonInit() {
        view = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!.loadNibNamed("BasePageControl", owner: self, options: nil)![0] as? UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //view.backgroundColor = .orange
        self.addSubview(view)
        
    }
    
}

@IBDesignable
class LKPageControl: UIControl {
  //MARK:- Properties
  
  private var numberOfDots = [UIView]() {
    didSet{
      if numberOfDots.count == numberOfPages {
        setupViews()
      }
    }
  }
  
  @IBInspectable var numberOfPages: Int = 0 {
    didSet{
      
      for tag in 0 ..< numberOfPages {
        let dot = getDotView()
        dot.tag = tag
        dot.backgroundColor = pageIndicatorTintColor
        self.numberOfDots.append(dot)
      }
      
    }
  }
  
  var currentPage: Int = 0 {
    didSet{
      print("CurrentPage is \(currentPage)")
    }
  }
  
    @IBInspectable var pageIndicatorTintColor: UIColor? = AppColor.eAnd_Grey_100
    @IBInspectable var currentPageIndicatorTintColor: UIColor? = AppColor.eAnd_Red
  
  private lazy var stackView = UIStackView.init(frame: self.bounds)
  private lazy var constantSpace = ((stackView.spacing) * CGFloat(numberOfPages - 1) + ((self.bounds.height * 0.48) * CGFloat(numberOfPages)) - self.bounds.width)
  
  
  override var bounds: CGRect {
    didSet{
      self.numberOfDots.forEach { (dot) in
        self.setupDotAppearance(dot: dot)
      }
    }
  }
  
  //MARK:- Intialisers
  convenience init() {
    self.init(frame: .zero)
  }
  
  init(withNoOfPages pages: Int) {
    self.numberOfPages = pages
    self.currentPage = 0
    super.init(frame: .zero)
    setupViews()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
  }
  private func setupViews() {
    
    self.numberOfDots.forEach { (dot) in
      self.stackView.addArrangedSubview(dot)
    }
   
    
    stackView.alignment = .center
    stackView.axis = .horizontal
    stackView.distribution = .fill
    stackView.spacing = 4
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(stackView)
    
    
    self.addConstraints([
      
      stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      stackView.heightAnchor.constraint(equalTo: self.heightAnchor),
      
      ])
      var index = 0
    
    self.numberOfDots.forEach { dot in
      
            self.addConstraints([
              dot.widthAnchor.constraint(equalToConstant: 4),
              dot.heightAnchor.constraint(equalToConstant: 4)
              ])
    
    }
    
  }
  
  @objc private func onPageControlTapped(_ sender: UITapGestureRecognizer) {
    
    guard let selectedDot = sender.view else { return }
      selectedDot.widthAnchor.constraint(equalToConstant: 17).isActive = true
      UIView.animate(withDuration: 0.2, animations: {
          //layoutIfNeeded()
        //dot.layer.cornerRadius = dot.bounds.height / 2
        //dot.transform = CGAffineTransform.init(scaleX: 2, y: 1)
          self.stackView.layoutIfNeeded()
        selectedDot.backgroundColor = self.currentPageIndicatorTintColor
      })
      
//    _ = numberOfDots.map { (dot) in
//      setupDotAppearance(dot: dot)
//      if dot.tag == selectedDot.tag {
//        currentPage = selectedDot.tag
//
//        UIView.animate(withDuration: 0.2, animations: {
//
//          //dot.layer.cornerRadius = dot.bounds.height / 2
//          //dot.transform = CGAffineTransform.init(scaleX: 2, y: 1)
//          selectedDot.backgroundColor = self.currentPageIndicatorTintColor
//        })
//        self.sendActions(for: .valueChanged)
//      }
//    }
    
  }
  
  //MARK: Helper methods...
  private func getDotView() -> UIView {
    let dot = UIView()
    self.setupDotAppearance(dot: dot)
    dot.translatesAutoresizingMaskIntoConstraints = false
    dot.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onPageControlTapped(_:))))
    return dot
  }
  
  private func setupDotAppearance(dot: UIView) {
    dot.transform = .identity
    dot.layer.cornerRadius = dot.bounds.height / 2
    dot.layer.masksToBounds = true
    dot.backgroundColor = pageIndicatorTintColor
  }
  
}
