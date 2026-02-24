# Shared Expense Manager

A simple Rails application to help couples manage shared expenses and monthly settlements.

## Features

- Record shared expenses
- Record personal transfers
- Automatic monthly settlement calculation
- Local-first and simple design

## Built With

- Ruby 3.2.6
- Ruby on Rails 8.0.4
- SQLite 3

## Getting Started

### 1. Clone the repository

```bash
$ git clone https://github.com/ckanayama/shared-expense-manager.git
$ cd shared-expense-manager
```

### 2. Setup

```bash
$ bundle install
$ bin/rails db:create
$ bin/rails db:migrate
```

### 3. Start the server

```bash
$ bin/dev
```

## Usage

1. Add expenses with date, payer, and amount.
2. Select a month to view monthly summary.
3. The system calculates how much each person should settle.
