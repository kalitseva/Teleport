//
//  SalariesTableCell.swift
//  Teleport
//
//  Created by Майя Калицева on 14.05.2022.
//

import RxCocoa
import RxSwift
import RxGesture
import CoreServices

final class SalariesTableCell: UITableViewCell {

    // MARK: Private Properies
    
    private var bag = DisposeBag()
    
    private let jobName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = UIColor.black.withAlphaComponent(0.8)
        lbl.backgroundColor = UIColor.systemPink.withAlphaComponent(0.4)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let percentileInformation: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textColor = UIColor.black.withAlphaComponent(0.8)
        lbl.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.2)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let percentile25: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = UIColor.black.withAlphaComponent(0.8)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let percentile50: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = UIColor.black.withAlphaComponent(0.8)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let percentile75: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = UIColor.black.withAlphaComponent(0.8)
        lbl.numberOfLines = 0
        return lbl
    }()

    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        cellStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life-cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    
    // MARK: Public Methods

    func setJobInfo(jobNames: SalaryMiddle) {
        percentileInformation.text = "Job percentiles: "
        jobName.text = jobNames.job.title
        percentile25.text = String("25%: \(Int(jobNames.salaryPercentiles.percentile25))")
        percentile50.text = String("50%: \(Int(jobNames.salaryPercentiles.percentile50))")
        percentile75.text = String("75%: \(Int(jobNames.salaryPercentiles.percentile75))")
    }
    
    // MARK: Private Methods
    
    private func cellStyle() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    private func setupLayout() {
        addSubview(jobName)
        addSubview(percentileInformation)
        addSubview(percentile25)
        addSubview(percentile50)
        addSubview(percentile75)

        jobName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(percentileInformation.snp.top).inset(-10)
        }
        
        percentileInformation.snp.makeConstraints { make in
            make.top.equalTo(jobName.snp.bottom).inset(10)
            make.leading.equalToSuperview().inset(5)
            make.bottom.equalTo(percentile25.snp.top).inset(-10)
        }
        
        percentile25.snp.makeConstraints { make in
            make.top.equalTo(percentileInformation.snp.bottom).inset(10)
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalTo(percentile50.snp.top).inset(-10)
        }
        
        percentile50.snp.makeConstraints { make in
            make.top.equalTo(percentile25.snp.bottom).inset(10)
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalTo(percentile75.snp.top).inset(-10)
        }
        
        percentile75.snp.makeConstraints { make in
            make.top.equalTo(percentile50.snp.bottom).inset(10)
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}


