# DB設計

## users 

| Column             | Type                | Options                 |
|--------------------|---------------------|-------------------------|
| nickname           | string              | null: false             |
| email              | string              | null: false             |
| password           | string              | null: false             |
| first_name         | string              | null: false             |
| last_name          | string              | null: false             |
| first_name_kana    | string              | null: false             |
| last_name_kana     | string              | null: false             |
| birth_year         | date                | null: false             |
| birth_month        | date                | null: false             |
| birth_day          | date                | null: false             |


### Association

* has_many :items

## items

| Column             | Type                | Options                        |
|--------------------|---------------------|--------------------------------|
| item_name          | string              | null: false                    |
| introduction       | text                | null: false                    |
| category           | string              | null: false                    |
| item_condition     | string              | null: false                    |
| postage_type       | integer             | null: false                    |
| preparation_day    | date                | null: false                    |
| prefecture_code    | integer             | null: false                    |
| price              | integer             | null: false                    |
| users              | references          | null: false, foreign_key: true |
| item_img           | references          | null: false, foreign_key: true |


### Association

- belongs_to :user
- belongs_to :buyer

## buyers

| Column          | Type                | Options                        |
|-----------------|---------------------|--------------------------------|
| price           | integer             | null: false                    |
| post_code       | integer(7)          | null: false                    |
| prefecture_code | integer             | null: false                    |
| city            | string              | null: false                    |
| house_number    | string              | null: false                    |
| items           | references          | null: false, foreign_key: true |

### Association

- has_many :items
- has_one :address

## address

| Column                  | Type                | Options                        |
|-------------------------|---------------------|--------------------------------|
| address_first_name      | string              | null: false                    |
| address_last_name       | string              | null: false                    |
| address_first_name_kana | string              | null: false                    |
| address_last_name_kana  | string              | null: false                    |
| post_code               | integer(7)          | null: false                    |
| prefecture_code         | integer             | null: false                    |
| city                    | string              | null: false                    |
| house_number            | string              | null: false                    |
| phone_number            | integer             | null: false                    |
| users                   | references          | null: false, foreign_key: true |

### Association

- belongs_to :buyer