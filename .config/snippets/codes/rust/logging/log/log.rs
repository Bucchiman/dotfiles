/*
 * FileName:     log
 * Author: 8ucchiman
 * CreatedDate:  2023-02-08 18:43:20 +0900
 * LastModified: 2023-02-08 18:51:07 +0900
 * Reference: 8ucchiman.jp
 */

use log::{info, warn};

pub fn shave_the_yak(yak: &mut Yak){
    info!(target: "yak_events", "Commencing yak shaving for {:?}", yak);
    loop {
        match find_a_razor() {
            Ok(razor) => {
                info!("Razor located: {}", razor);
                yak.shave(razor);
                break;
            }
            Err(err) => {
                warn! ("Unable to locate a razor: {}, retrying", err);
            }
        }
    }
}
