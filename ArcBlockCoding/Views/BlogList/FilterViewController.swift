import UIKit
import SnapKit

class FilterViewController: UIViewController {
	private var collectionView: UICollectionView!

	var labels : [Label] = []
	
	private let overlayView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
		view.isHidden = true
		return view
	}()
	
	private let filterView: UIView = {
		let view = UIView()
		view.backgroundColor = ColorUtil.backgroundColor
		view.layer.cornerRadius = 8
		view.layer.masksToBounds = true
		return view
	}()
	
	let clearButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Clear", for: .normal)
		button.addTarget(
			self, action: #selector(handleClear), for: .touchUpInside)
		return button
	}()
	
	let doneButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Done", for: .normal)
		button.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
		return button
	}()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .clear
		setupUI()
	}
	
	func loadLabels() {
		Task {
			do {
				let labels = try await ServiceBlog.shared.fetchLabels()
				self.labels = labels
				if let collectionView = collectionView {
					collectionView.reloadData()
				}
				// 更新UI或者处理返回的 labels 数据
			} catch {
				print("Error fetching labels: \(error)")
			}
		}
	}
	
	private func setupUI() {
		// 蒙层视图
		view.addSubview(overlayView)
		overlayView.frame = CGRect(x: 0, y: 0, width: 120, height: LayoutUtil.screenHeight)
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleOverlayTap))
		overlayView.addGestureRecognizer(tapGesture)
		view.addSubview(filterView)
		
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
		layout.minimumInteritemSpacing = 8
		layout.minimumLineSpacing = 8
		
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = ColorUtil.backgroundColor
		collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: "TagCell")
		collectionView.dataSource = self
		collectionView.delegate = self
		filterView.addSubview(collectionView)
		
		collectionView.snp.makeConstraints { make in
			make.top.left.right.equalToSuperview()
			make.bottom.equalToSuperview().inset(100)
		}
		
		let buttonStackView = UIStackView(arrangedSubviews: [clearButton, doneButton])
		buttonStackView.axis = .horizontal
		buttonStackView.spacing = 20
		buttonStackView.distribution = .fillEqually
		
		filterView.addSubview(buttonStackView)
		
		buttonStackView.snp.makeConstraints { make in
			make.left.right.equalToSuperview().inset(20)
			make.top.equalTo(collectionView.snp.bottom).offset(8)
			make.height.equalTo(40)
		}
	}
	
	@objc private func handleClear() {
		for index in 0..<labels.count {
			labels[index].isSelected = false
		}

		collectionView.reloadData()
	}
	
	var onLabelsSelected: (([Label]) -> Void)?

	
	@objc private func handleDone() {
		let selectedLabels = labels.filter { $0.isSelected }
		onLabelsSelected?(selectedLabels)
		
		hide()
	}
	
	@objc private func handleOverlayTap() {
		hide()
	}
	
	func show() {
		let windows = UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.last { $0.isKeyWindow }


		windows?.addSubview(self.view);
		view.frame = CGRect(x: 0, y: 0, width: LayoutUtil.screenWidth, height: LayoutUtil.screenHeight)
		filterView.frame = CGRect(x: LayoutUtil.screenWidth, y: 0, width: LayoutUtil.screenWidth - 120, height: LayoutUtil.screenHeight)
		UIView.animate(withDuration: 0.2) {
			self.filterView.frame = CGRect(x: 120, y: 0, width: LayoutUtil.screenWidth - 120, height: LayoutUtil.screenHeight)
		} completion: { success in
			self.overlayView.isHidden = false;

		}
		collectionView.reloadData()

	}
	
	func hide() {
		self.overlayView.isHidden = true;
		UIView.animate(withDuration: 0.2) {
			self.filterView.frame = CGRect(x: LayoutUtil.screenWidth, y: 0, width: LayoutUtil.screenWidth - 120, height: LayoutUtil.screenHeight)

		} completion: { success in
			self.view.removeFromSuperview()
		}
	}
}


extension FilterViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return labels.count
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		1
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCollectionViewCell
		cell.configure(with: labels[indexPath.item])
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let label = labels[indexPath.item]
		let width = label.name.size(withAttributes: [.font: UIFont.systemFont(ofSize: 14)]).width + 10
		return CGSize(width: width, height: 40) // 根据内容大小自动调整宽度
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 5
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 5
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets.zero
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		var label = labels[indexPath.row]
		label.isSelected = !label.isSelected
		labels[indexPath.row] = label
		collectionView.reloadItems(at: [indexPath])
	}

}

class TagCollectionViewCell: UICollectionViewCell {
	
	private let label: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = .black
		label.textAlignment = .center
		label.layer.cornerRadius = 5
		label.layer.masksToBounds = true
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.addSubview(label)
		label.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		contentView.layer.cornerRadius = 8
		contentView.backgroundColor = ColorUtil.Container0
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(with model: Label) {
		label.text = model.name
		contentView.backgroundColor = model.isSelected ? ColorUtil.primaryColor : ColorUtil.textColor
	}

	
}
