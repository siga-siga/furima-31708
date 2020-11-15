# Furima-31708 DB設計図

## Usersテーブル

| Column          | Type   | Option      |
| --------------- | ------ | ----------- |
| nickname        | string | null: false |
| email           | string | null: false |
| last_name       | string | null: false |
| first_name      | string | null: false |
| last_name_kana  | string | null: false |
| first_name_kana | string | null: false |
| birthday        | date   | null: false |

Association
has_many :items
has_many :purchases

## Itemsテーブル 

| Column            | Type       | Option                         |
| ----------------- | ---------- | ------------------------------ |
| name              | string     | null: false                    |
| content           | text       | null: false                    |
| category_id       | integer    | null: false                    |
| status_id         | integer    | null: false                    |
| shipping_payer_id | integer    | null: false                    |
| area_id           | integer    | null: false                    |
| delivery_days_id  | integer    | null: false                    |
| price             | date       | null: false                    |
| user              | references | null: false, foreign_key: true |

Association
belongs_to :user
has_one :purchase

## Purchasesテーブル

| Column | Type       | Option                         |
| ------ | ---------- | ------------------------------ |
| item   | references | null: false, foreign_key: true |
| user   | references | null: false, foreign_key: true |

Association
belongs_to :user
belongs_to :item
has_one :address

## Addressesテーブル

| Column           | Type       | Option                         |
| ---------------- | ---------- | ------------------------------ |
| postal_code      | string     | null: false                    |
| prefecture_id    | integer    | null: false                    |
| city             | string     | null: false                    |
| block            | string     | null: false                    |
| building         | string     |                                |
| phone            | string     | null: false                    |
| purchase         | references | null: false, foreign_key: true |

Association
belongs_to :purchase
