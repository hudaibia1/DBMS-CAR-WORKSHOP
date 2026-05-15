# Milestone 2: Process & Steps Explained

This document outlines the steps taken to complete Milestone 2 of the Car Workshop Management System project. The core objective of this milestone was to refine the initial database schema (created in Milestone 1) by applying formal normalization techniques, removing redundancies, and updating the Entity-Relationship Diagram (ERD).

## Step 1: Apply Normalization
The first and most critical step involved reviewing every table in the initial schema and applying the normalization process sequentially: First Normal Form (1NF), Second Normal Form (2NF), and Third Normal Form (3NF).
*   **1NF (First Normal Form)**: We ensured that all attributes are atomic. For instance, composite attributes like `Name` (in Customer and Mechanic tables) were split into `FirstName` and `LastName`. `Address` was split into `Street`, `City`, `State`, and `ZipCode`. `Model` in the Vehicle table was separated into `Make`, `ModelName`, and `Year`.
*   **2NF (Second Normal Form)**: We verified that all tables with composite primary keys have no partial dependencies. All non-key attributes fully depend on the primary key.
*   **3NF (Third Normal Form)**: We removed any transitive dependencies and derived attributes. Specifically, the `TotalCost` in the `ServiceJob` table and `Amount` in the `Invoice` table were removed because they can be dynamically calculated from parts and labor costs, preventing potential update anomalies.

*For a detailed, table-by-table breakdown of these normalization changes, please refer to the `NORMALIZATION.md` file.*

## Step 2: Remove Duplicates
During the normalization process, we actively checked for redundant columns, repeated data, or overlapping attributes across tables.
*   **Redundancy Resolved**: The derived cost/amount columns were a primary source of redundancy. By removing `TotalCost` from `ServiceJob` and `Amount` from `Invoice`, we eliminated duplicate representations of the same financial data. Instead, a `LaborCost` attribute was added to `ServiceJob`, allowing the final bill to be calculated on the fly without storing redundant totals.

## Step 3: Update Your ERD
With the normalized schema finalized, the Entity-Relationship Diagram (ERD) was updated to accurately reflect the new structure.
*   **Visual Updates**: The revised attributes (like the split names and addresses) and the corrected columns (like `LaborCost` replacing `TotalCost`) were mapped out.
*   **Relationships**: Primary keys, foreign keys, and relationship cardinalities were carefully re-verified to ensure they correctly represent the optimized database structure. The visual `.png` version of this updated diagram is saved in this folder.

## Step 4: Commit to GitHub
The final step involved documenting the work and committing it to version control.
*   A dedicated `NORMALIZATION.md` document was created to thoroughly explain the 1NF, 2NF, and 3NF justifications.
*   The updated ERD diagram (`ERD.png` / `er.png`) was generated and included.
*   These files were organized into the `Milestone2` directory, and all changes are tracked to demonstrate the systematic evolution of the database design.
