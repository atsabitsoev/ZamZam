//
//  LimitsTableView.swift
//  TestTaskZamZam
//
//  Created by Iliya B on 04/07/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit


extension LimitsVC: UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "limitCell")!
        return cell

    }

}
