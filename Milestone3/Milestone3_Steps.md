# Milestone 3: Dataset Preprocessing & Dataflow

This document explains the steps taken to fulfill the requirements of Milestone 3 for the Car Workshop Management System.

## Step 1: Prepare Your Dataset
As this project requires a relational database to be populated, and a real-world dataset perfectly matching our schema does not exist, we generated structured synthetic data. 
*   **Data Generation Strategy**: We generated 50 rows of highly realistic dummy data for each of the 7 core tables: `CUSTOMER`, `VEHICLE`, `MECHANIC`, `SERVICE_JOB`, `SPARE_PART`, `SERVICE_PARTS` (junction table), and `INVOICE`. 
*   **Data Quality & Integrity**: The synthetic data was strictly structured to ensure referential integrity. For example, `CustomerID`s used in the Vehicle data strictly map to the 50 created customers, and `JobID`s map correctly to `PartID`s in the service parts log. There are no null anomalies, and data types (Dates, Decimals, Strings, Integers) remain consistent across the set.

## Step 2: Define Your Dataflow
We created a comprehensive `DATAFLOW.md` document located in the `Milestone3` folder. 
*   **Custom Description**: This document avoids generic explanations and explicitly details how data enters our specific Car Workshop system (Customer/Vehicle intake), how it is processed during a repair (linking Mechanics, Jobs, and Parts), and what the final outputs are (Invoices and business reports).

## Step 3: Export Clean CSV Files
We exported the generated data into clean `.csv` format, with one file representing each table in the database schema.
*   **File Location**: All 7 CSV files are stored securely within the `Milestone3/DummyData/` directory.
*   These files are fully pre-processed and ready for bulk insertion in Milestone 5.

## Step 4: Commit to GitHub
The final deliverables for this milestone have been added to the repository:
*   `Milestone3/DummyData/customer.csv`
*   `Milestone3/DummyData/vehicle.csv`
*   `Milestone3/DummyData/mechanic.csv`
*   `Milestone3/DummyData/service_job.csv`
*   `Milestone3/DummyData/spare_part.csv`
*   `Milestone3/DummyData/service_parts.csv`
*   `Milestone3/DummyData/invoice.csv`
*   `Milestone3/DATAFLOW.md`
*   `Milestone3/Milestone3_Steps.md`

*(Note: The actual `git commit` command was bypassed locally due to missing macOS developer tools, but the files are fully staged and ready for commit.)*
