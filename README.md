# Blue Onion Labs Take Home Assignment

Thank you for your interest in Blue Onion!

This assignment is designed to give you an opportunity to demonstrate your skills and experience in a practical format similar to what you would be doing as a member of our team. We are primarily a Rails shop, so if possible we would like you to use Ruby on Rails + React for this assignment.

## Background

In our hypothetical scenario, we have a client who needs to track their sales, shipping, and tax information for their online store. This data must be aggregated into monthly journal entries for their accounting system. The client has provided us with a CSV file containing their orders and payments for the year 2023. Your task is to build a web application to display these journal entries.

Provided in this repository is a [CSV file containing the relevant data for your application](/data.csv).

**Note:**
Each order and its associated transactions (including multiple payments) should be processed individually. However, the final output must be a single, consolidated journal entry for each month (determined by the `ordered_at` date). This means:
- All orders within a selected month are aggregated into one journal entry.
- If an order has multiple payments, these should be summed up and displayed as one consolidated payment total in the journal entry.

Journal entries are used to record financial transactions in a double-entry accounting system. This means that for each transaction, there are two entries: a debit and a credit. The sum of the debits must equal the sum of the credits. For more information on how journal entries work, see [this article](https://www.moderntreasury.com/journal/accounting-for-developers-part-i).

## Product Requirements

Build a web application that displays the client's monthly aggregated journal entries for the data provided. For an example of how journal entries should be structured see the example journal entry here: ([csv version](/example_journal_entries.csv), [excel version](/example_journal_entries.xlsx)). Please note that the example journal entry is not based on the data provided in the CSV file.

### Features
- **Monthly Aggregated Journal Entry**
  - Only one consolidated journal entry should be generated per month.
  - Users will select a month to view the corresponding aggregated journal entry.
- **Line Items Included**
  - **Sales (Revenue)**
    - Debit to Accounts Receivable: Represents the money expected to be received for orders placed.
    - Credit to Revenue: Represents the revenue earned from orders placed.
  - **Shipping**
    - Debit to Accounts Receivable: Represents the money expected to be received for shipping fees.
    - Credit to Shipping Revenue: Represents the revenue earned from shipping fees charged.
  - **Taxes**
    - Debit to Accounts Receivable: Represents the total sales tax charged for orders placed.
    - Credit to Sales Tax Payable: Represents the obligation to remit the collected sales tax to the appropriate tax authority.
  - **Payments**
    - Debit to Cash: Represents the money received from payments for orders placed.
    - Credit to Accounts Receivable: Represents the reduction in the amount expected to be received due to the payment.
    - **Clarification:** If an order includes multiple payments, these should be aggregated so that the journal entry reflects the total payment received for that month.
- **Total Line Item**
  - Include a line that sums the debits and credits for each category, ensuring the journal entries balance.

### Calculations

Below are the formulas for calculating the values for each category:
- **Sales:** `price_per_item * quantity`
- **Shipping:** `shipping`
- **Taxes:** `sales * tax_rate`
- **Payments:** `payment_amount`

Make sure all values are aggregated by month as determined by the `ordered_at` date on the order.

## Technical Requirements

### Database

- Use a database of your choice.
- Design a schema to store the data from the CSV file.
- Import data from the CSV file into the database.

### Back End

- Build the API using a modern back end framework, ideally Ruby on Rails.
- Develop the necessary logic to compute and aggregate data for the front end.
- Create an API endpoint for the front end to fetch the required data.

### Front End

- Build the user interface using a modern front end framework, ideally React.
- Build a simple web application to display the journal entries with a form to select a month.

### Documentation

- Provide a README with instructions on how to run the application.
- Include a brief explanation of the decisions you made in your implementation, including any assumptions about data aggregation.

## Submission

Please provide a link to a repository (GitHub, GitLab, etc.) containing your code. If you have any questions or need clarification on the requirements, please don't hesitate to reach out.

We recognize that this assignment is both comprehensive and time intensive, and deeply appreciate the time you dedicate to it. While we encourage you to showcase your best work, if there are areas you choose not to prioritize, we'd greatly value insight into your decision-making process.

Good luck!

