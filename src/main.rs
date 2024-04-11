use chrono::NaiveDateTime;
use serde::{Deserialize, Serialize};
use uuid::Uuid;


#[derive(Serialize, Deserialize)]
pub struct Car {
    pub id: Uuid,
    pub created_at: NaiveDateTime,
}


fn fine() {
    let _cars = sqlx::query_as!(
        Car,
        "SELECT id, created_at FROM car",
    );
}

fn not_working() {
    let _cars = sqlx::query_as!(
        Car,
        "SELECT id, created_at FROM active_car",
    );
}


fn main() {
    println!("Rust bug on views?");
    fine();
    not_working();
}
