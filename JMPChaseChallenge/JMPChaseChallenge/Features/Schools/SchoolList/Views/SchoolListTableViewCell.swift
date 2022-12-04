//
//  SchoolListTableViewCell.swift
//  JMPChaseChallenge
//
//  Created by Yangbin Wen on 12/3/22.
//

import UIKit

class SchoolListTableViewCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        var lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        return lable
    }()
    
    let overview: UILabel = {
        var lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        return lable
    }()
    
    let totalStudents: UILabel = {
        var lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        return lable
    }()
    
    let schoolPhone: UILabel = {
        var lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        return lable
    }()
    
    let schoolEmail: UILabel = {
        var lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        return lable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        selectionStyle = .none
        contentView.addSubview(nameLabel)
        contentView.addSubview(overview)
        contentView.addSubview(totalStudents)
        contentView.addSubview(schoolPhone)
        contentView.addSubview(schoolEmail)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIConstants.mrginMedium),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIConstants.mrginMedium),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIConstants.marginBig),
            
            overview.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            overview.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: UIConstants.mrginSmall),
            overview.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: -UIConstants.mrginSmall),
            
            totalStudents.leadingAnchor.constraint(equalTo: overview.leadingAnchor),
            totalStudents.topAnchor.constraint(equalTo: overview.bottomAnchor, constant: UIConstants.mrginSmall),
            totalStudents.trailingAnchor.constraint(equalTo: overview.trailingAnchor, constant: -UIConstants.mrginSmall),
            
            schoolPhone.leadingAnchor.constraint(equalTo: totalStudents.leadingAnchor),
            schoolPhone.topAnchor.constraint(equalTo: totalStudents.bottomAnchor, constant: UIConstants.mrginSmall),
            schoolPhone.trailingAnchor.constraint(equalTo: totalStudents.trailingAnchor, constant: -UIConstants.mrginSmall),
            
            schoolEmail.leadingAnchor.constraint(equalTo: schoolPhone.leadingAnchor),
            schoolEmail.topAnchor.constraint(equalTo: schoolPhone.bottomAnchor, constant: UIConstants.mrginSmall),
            schoolEmail.trailingAnchor.constraint(equalTo: schoolPhone.trailingAnchor, constant: -UIConstants.mrginSmall),
            schoolEmail.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -UIConstants.marginBig)
        ])
    }
}

extension SchoolListTableViewCell: ConfigurableCell {
    
    typealias DataObject = SchoolListModel
    
    func configure(for object: DataObject) {
        nameLabel.text = object.schoolName
        overview.text = "Overview:\n \(object.overview)"
        totalStudents.text = "Totla Students: \(object.totalStudents)"
        schoolPhone.text = "Phone of school: \(object.phoneNumber)"
        schoolEmail.text = "Email of school: \(object.schoolEmail)"
    }
}
