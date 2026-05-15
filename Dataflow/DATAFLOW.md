# Dataflow: Car Workshop Management System

## 1. Data Entry Points (Input)
Data primarily enters our Car Workshop Management System when a customer arrives for a service or books an appointment.
*   **Customer & Vehicle Intake**: The process begins at the reception desk. A front-desk employee enters the customer's personal details into the `CUSTOMER` table. Following this, the details of the customer's vehicle (Make, Model, Year, RegNo) are registered into the `VEHICLE` table. The `VEHICLE` is explicitly linked to the `CUSTOMER` via the `CustomerID` foreign key.
*   **Inventory Restocking**: Separately, the workshop manager enters parts data into the `SPARE_PART` table when purchasing inventory from suppliers, establishing the initial stock quantities and pricing.
*   **Mechanic Onboarding**: Workshop administration inputs employee data into the `MECHANIC` table whenever a new mechanic joins the team.

## 2. Data Movement & Processing (Throughput)
Once the foundational data (Customers, Vehicles, Mechanics, Parts) is in the system, operational dataflow occurs through the servicing process.
*   **Service Job Creation**: A new record is created in the `SERVICE_JOB` table when a vehicle is assigned to a mechanic. This table centralizes the operational data by linking the `VehicleID` (what is being fixed) and the `MechanicID` (who is fixing it). The job initially starts with a `Status` of "Pending".
*   **Parts Consumption**: As the mechanic works on the vehicle, they requisition parts from the inventory. This action logs entries in the `SERVICE_PARTS` junction table. This table maps the `JobID` to the specific `PartID` and records the `QuantityUsed`. Consequently, the business logic (which will be implemented later via triggers or application code) depends on this flow to decrement the `Quantity` in the main `SPARE_PART` table.
*   **Labor Logging**: Upon job completion, the mechanic or service advisor updates the `SERVICE_JOB` table, changing the `Status` to "Completed" and logging the final `LaborCost`.

## 3. Data Output (Output)
The final stage of the dataflow involves generating billing information and reports for both the customer and the business.
*   **Invoice Generation**: Once a `SERVICE_JOB` is "Completed," the system processes the output. It reads the `LaborCost` from `SERVICE_JOB` and joins the `SERVICE_PARTS` with `SPARE_PART` to calculate the parts cost (`QuantityUsed` * `UnitPrice`). With this aggregated data, a new record is created in the `INVOICE` table linked to the `JobID`.
*   **Customer Billing**: The data from the `INVOICE`, `CUSTOMER`, and `VEHICLE` tables is extracted and formatted into a final, printable bill for the customer.
*   **Business Reporting**: Management can query the system to extract analytical outputs, such as "Total Revenue per Mechanic," "Most Frequently Used Spare Parts," or "Unpaid Invoices," using the robust relational links established throughout the database.
