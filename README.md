### What?
Minimal demo to test the rust SQLx macro query_as! on a postgres view fails.

### How to run?
Assuming you have docker and rust installed, run the script:

```shell
bash ./run.sh
```

This will:
1. Spin up a instance of postgres on `localhost:5432`
2. Initialize the database with 1 table + 1 view of that table
3. Run `cargo build`

### Result

At the end of the script you should see the error:

```rust
Loading...                  cargo build 
   Compiling sqlx-view v0.1.0 (/Users/alexisgaziello/local/rust/bug/sqlx-view)
error[E0277]: the trait bound `Uuid: From<std::option::Option<Uuid>>` is not satisfied
  --> src/main.rs:21:17
   |
21 |       let _cars = sqlx::query_as!(
   |  _________________^
22 | |         Car,
23 | |         "SELECT id, created_at FROM active_car",
24 | |     );
   | |_____^ the trait `From<std::option::Option<Uuid>>` is not implemented for `Uuid`
   |
   = help: the following other types implement trait `From<T>`:
             <Uuid as From<Hyphenated>>
             <Uuid as From<uuid::fmt::Simple>>
             <Uuid as From<Urn>>
             <Uuid as From<Braced>>
   = note: required for `std::option::Option<Uuid>` to implement `Into<Uuid>`
   = note: this error originates in the macro `$crate::sqlx_macros::expand_query` which comes from the expansion of the macro `sqlx::query_as` (in Nightly builds, run with -Z macro-backtrace for more info)

error[E0277]: the trait bound `NaiveDateTime: From<std::option::Option<NaiveDateTime>>` is not satisfied
  --> src/main.rs:21:17
   |
21 |       let _cars = sqlx::query_as!(
   |  _________________^
22 | |         Car,
23 | |         "SELECT id, created_at FROM active_car",
24 | |     );
   | |_____^ the trait `From<std::option::Option<NaiveDateTime>>` is not implemented for `NaiveDateTime`
   |
   = help: the trait `From<NaiveDate>` is implemented for `NaiveDateTime`
   = help: for that trait implementation, expected `NaiveDate`, found `std::option::Option<NaiveDateTime>`
   = note: required for `std::option::Option<NaiveDateTime>` to implement `Into<NaiveDateTime>`
   = note: this error originates in the macro `$crate::sqlx_macros::expand_query` which comes from the expansion of the macro `sqlx::query_as` (in Nightly builds, run with -Z macro-backtrace for more info)

For more information about this error, try `rustc --explain E0277`.
error: could not compile `sqlx-view` (bin "sqlx-view") due to 2 previous errors

```

