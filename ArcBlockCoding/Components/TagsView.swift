import UIKit

class LabelView: UIView {
	
	var label: UILabel!
	var paddingH: CGFloat = 4.0
	
	init(text: String, paddingH: CGFloat = 4.0) {
		super.init(frame: .zero)
		self.paddingH = paddingH
		label = UILabel()
		label.text = text
		label.textAlignment = .center
		label.textColor = ColorUtil.textColor2
		label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
		label.layer.borderColor = UIColor(white: 0.88, alpha: 1).cgColor
		label.layer.borderWidth = 1
		label.layer.cornerRadius = 4
		label.layer.masksToBounds = true
		label.backgroundColor = UIColor(white: 0.96, alpha: 1)
		
		addSubview(label)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setText(_ text: String, maxWidth: CGFloat) {
		label.text = text
		let textWidth = calculateTextWidth(text, font: label.font)
		let labelWidth = min(textWidth + paddingH * 2, maxWidth)
		
		label.frame = CGRect(x: 0, y: 0, width: labelWidth, height: 20)
	}
	
	private func calculateTextWidth(_ text: String, font: UIFont) -> CGFloat {
		let attributes: [NSAttributedString.Key: Any] = [.font: font]
		let size = (text as NSString).size(withAttributes: attributes)
		return size.width
	}
}

class TagsView: UIView {
	
	var labelViews: [LabelView] = []
	var maxLabelWidth: CGFloat = 100
	var horizontalSpacing: CGFloat = 8
	var verticalSpacing: CGFloat = 8
	var padding: CGFloat = 0
	
	// 数据源
	var labels: [String] = [] {
		didSet {
			layoutLabels()
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .clear
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// 布局标签
	private func layoutLabels() {
		// 清除之前的标签视图
		labelViews.forEach { $0.removeFromSuperview() }
		labelViews.removeAll()
		
		var currentX: CGFloat = padding
		var currentY: CGFloat = padding
		var maxHeightInRow: CGFloat = 0
		
		for text in labels {
			let labelView = LabelView(text: text, paddingH: 4)
			labelView.setText(text, maxWidth: maxLabelWidth)
			labelViews.append(labelView)
			
			let labelWidth = labelView.label.frame.width
			let labelHeight = labelView.label.frame.height
			
			if currentX + labelWidth > bounds.width - padding {
				currentX = padding
				currentY += maxHeightInRow + verticalSpacing
				maxHeightInRow = 0
				
				labelView.frame = CGRect(x: currentX, y: currentY, width: labelWidth, height: labelHeight)
				currentX += labelWidth + horizontalSpacing
			} else {
				labelView.frame = CGRect(x: currentX, y: currentY, width: labelWidth, height: labelHeight)
				currentX += labelWidth + horizontalSpacing
			}
			
			maxHeightInRow = max(maxHeightInRow, labelHeight)
			
			addSubview(labelView)
		}
		let totalHeight = currentY + maxHeightInRow
		frame.size.height = totalHeight
	}
}
