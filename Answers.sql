To complete your MongoDB assignment, you'll need to set up MongoDB, populate your database, and then write queries in the MongoDB Shell or Compass. Here's a breakdown of the steps and the content for your queries.js and README.md files.
Task 1: MongoDB Setup
Installation (Choose one):
 * Local Machine: Follow the official MongoDB Community Edition installation guide for your operating system.
   * MongoDB Installation Guides
 * MongoDB Atlas:
   * Go to MongoDB Atlas and sign up for a free account.
   * Create a new cluster (select the free tier).
   * Follow the instructions to set up your IP Whitelist (allow access from anywhere for this exercise, or your current IP) and create a database user.
   * Get your connection string (usually starts with mongodb+srv://). You'll need to replace mongodb://localhost:27017 in insert_books.js with this connection string, making sure to substitute <username> and <password> with your database user credentials.
Database and Collection Creation:
The insert_books.js script will automatically create the plp_bookstore database and the books collection if they don't exist. If the books collection already exists and has documents, the script will drop it and re-insert the data.
Task 2: Basic CRUD Operations
Populate Data:
 * Save the insert_books.js script: Save the provided JavaScript code into a file named insert_books.js in your project directory.
 * Run the script:
   * If using local MongoDB: Open your terminal or command prompt, navigate to the directory where you saved insert_books.js, and run:
     node insert_books.js

   * If using MongoDB Atlas: Ensure you've updated the uri in insert_books.js with your Atlas connection string. Then, run the command above.
You should see output indicating that the connection was successful, documents were inserted, and then a list of the inserted books.
MongoDB Queries (to be saved in queries.js):
Here are the queries for your queries.js file. You can execute these directly in mongosh (MongoDB Shell) or MongoDB Compass.
// queries.js - MongoDB queries for plp_bookstore database

// Connect to the plp_bookstore database
// If you are running this in mongosh, you can just type 'use plp_bookstore;'
// If you are connecting from a Node.js script, you'd handle the connection similar to insert_books.js

// --- Task 2: Basic CRUD Operations ---

// Find all books in a specific genre (e.g., 'Fiction')
db.books.find({ genre: "Fiction" });

// Find books published after a certain year (e.g., 1950)
db.books.find({ published_year: { $gt: 1950 } });

// Find books by a specific author (e.g., 'George Orwell')
db.books.find({ author: "George Orwell" });

// Update the price of a specific book (e.g., '1984' to 11.99)
db.books.updateOne(
  { title: "1984" },
  { $set: { price: 11.99 } }
);
// To verify the update:
db.books.find({ title: "1984" });

// Delete a book by its title (e.g., 'Moby Dick')
db.books.deleteOne({ title: "Moby Dick" });
// To verify the deletion:
db.books.find({ title: "Moby Dick" });

// --- Task 3: Advanced Queries ---

// Find books that are both in stock and published after 2010
db.books.find({
  in_stock: true,
  published_year: { $gt: 2010 }
});

// Use projection to return only the title, author, and price fields (e.g., for all books)
db.books.find(
  {},
  { title: 1, author: 1, price: 1, _id: 0 } // _id: 0 excludes the default _id field
);

// Implement sorting to display books by price (ascending)
db.books.find().sort({ price: 1 });

// Implement sorting to display books by price (descending)
db.books.find().sort({ price: -1 });

// Use the limit and skip methods to implement pagination (5 books per page)
// Page 1:
db.books.find().limit(5).skip(0);
// Page 2:
db.books.find().limit(5).skip(5);
// Page 3: (if enough books exist)
db.books.find().limit(5).skip(10);


// --- Task 4: Aggregation Pipeline ---

// Calculate the average price of books by genre
db.books.aggregate([
  {
    $group: {
      _id: "$genre",
      averagePrice: { $avg: "$price" }
    }
  }
]);

// Find the author with the most books in the collection
db.books.aggregate([
  {
    $group: {
      _id: "$author",
      bookCount: { $sum: 1 }
    }
  },
  {
    $sort: {
      bookCount: -1
    }
  },
  {
    $limit: 1
  }
]);

// Implement a pipeline that groups books by publication decade and counts them
db.books.aggregate([
  {
    $project: {
      _id: 0,
      title: 1,
      published_decade: {
        $concat: [
          { $toString: { $subtract: ["$published_year", { $mod: ["$published_year", 10] }] } },
          "s"
        ]
      }
    }
  },
  {
    $group: {
      _id: "$published_decade",
      bookCount: { $sum: 1 }
    }
  },
  {
    $sort: {
      _id: 1 // Sort by decade ascending
    }
  }
]);


// --- Task 5: Indexing ---

// Create an index on the title field for faster searches
db.books.createIndex({ title: 1 });

// Create a compound index on author and published_year
db.books.createIndex({ author: 1, published_year: 1 });

// Use the explain() method to demonstrate the performance improvement with your indexes
// Before index (if you drop it first for demonstration):
// db.books.dropIndex({ title: 1 }); // Uncomment and run if you want to see before index
db.books.find({ title: "1984" }).explain("executionStats");

// After index: (Make sure the index is created first)
db.books.find({ title: "1984" }).explain("executionStats");

// Example of explain with compound index
db.books.find({ author: "George Orwell", published_year: 1949 }).explain("executionStats");

README.md File
Create a README.md file in your repository with the following content:
# MongoDB Data Layer Fundamentals and Advanced Techniques

This repository contains the solution for the MongoDB Week 1 assignment, focusing on data layer fundamentals and advanced techniques.

## 🚀 Objective

The objective of this assignment was to learn the fundamentals of MongoDB, including installation, creating collections, performing CRUD operations, using aggregation pipelines, and implementing indexing for performance optimization.

## 📂 Tasks Completed

* **Task 1: MongoDB Setup**
    * MongoDB installed locally (or MongoDB Atlas cluster set up).
    * `plp_bookstore` database created.
    * `books` collection created and populated using `insert_books.js`.

* **Task 2: Basic CRUD Operations**
    * Used `insert_books.js` to insert at least 10 book documents.
    * Implemented queries to:
        * Find all books in a specific genre.
        * Find books published after a certain year.
        * Find books by a specific author.
        * Update the price of a specific book.
        * Delete a book by its title.

* **Task 3: Advanced Queries**
    * Wrote a query to find books that are both in stock and published after 2010.
    * Used projection to return only specific fields.
    * Implemented sorting by price (ascending and descending).
    * Used `limit` and `skip` for pagination.

* **Task 4: Aggregation Pipeline**
    * Created a pipeline to calculate the average price of books by genre.
    * Created a pipeline to find the author with the most books.
    * Implemented a pipeline to group books by publication decade and count them.

* **Task 5: Indexing**
    * Created an index on the `title` field.
    * Created a compound index on `author` and `published_year`.
    * Used `explain()` to demonstrate performance improvements.

## 🛠️ Setup and How to Run

1.  **Install MongoDB:**
    * **Local:** Download and install MongoDB Community Edition from the [official MongoDB website](https://www.mongodb.com/try/download/community).
    * **MongoDB Atlas:** Sign up for a free tier account on [MongoDB Atlas](https://www.mongodb.com/cloud/atlas) and create a new cluster. Obtain your connection string.

2.  **Prerequisites:**
    * Node.js and npm installed (for running `insert_books.js`).

3.  **Clone the Repository:**
    ```bash
    git clone <your-github-classroom-repo-link>
    cd <your-repository-name>
    ```

4.  **Populate the Database:**
    * If using MongoDB Atlas, open `insert_books.js` and **replace** `mongodb://localhost:27017` with your MongoDB Atlas connection string. Remember to replace `<username>` and `<password>` placeholders in the connection string with your actual database user credentials.
    * Run the script from your terminal:
        ```bash
        node insert_books.js
        ```
    This script will connect to your MongoDB instance, create the `plp_bookstore` database and `books` collection, and insert sample book data.

5.  **Execute Queries:**
    * **Using MongoDB Shell (mongosh):**
        1.  Open your terminal and type `mongosh`.
        2.  Connect to your database: `use plp_bookstore;`
        3.  You can then copy and paste the queries from `queries.js` directly into the `mongosh` prompt and press Enter to execute them.

    * **Using MongoDB Compass:**
        1.  Open MongoDB Compass and connect to your MongoDB instance (local or Atlas).
        2.  Navigate to the `plp_bookstore` database and then the `books` collection.
        3.  You can use the "Aggregations" tab for aggregation pipelines or the "Filter" bar and "Project", "Sort" options for basic and advanced queries. For `explain()` and direct execution, use the "Aggregations" tab and select "Raw Query" or the "Documents" tab with the "Find" button to construct your queries.

## ✅ Submission Files

The following files are included in this repository for submission:

* `insert_books.js`: The script used to populate the MongoDB database with sample book data.
* `queries.js`: Contains all the MongoDB queries for basic CRUD operations, advanced queries, aggregation pipelines, and indexing.
* `README.md`: This file, explaining the setup and how to run the scripts.
* `screenshot.png`: A screenshot showing the MongoDB Compass or Atlas interface with the `plp_bookstore` database and `books` collection and some sample data.

Screenshot
 * Take a screenshot of your MongoDB Compass or MongoDB Atlas interface.
 * Ensure the screenshot clearly shows your plp_bookstore database, the books collection within it, and some of the sample data (e.g., the documents listed).
 * Save this screenshot as screenshot.png in your repository.
Submission Instructions Summary
 * Accept Assignment: Accept the GitHub Classroom assignment invitation. This will create your personal repository.
 * Clone Repository: Clone your newly created repository to your local machine.
 * Place Files:
   * Save the provided insert_books.js (modified with Atlas URI if applicable) in your cloned repository.
   * Create and save the queries.js file (content provided above) in your cloned repository.
   * Create and save the README.md file (content provided above) in your cloned repository.
   * Place your screenshot.png file in the root of your cloned repository.
 * Commit and Push:
   git add .
git commit -m "Complete Week 1 MongoDB assignment"
git push origin main

This comprehensive guide should help you successfully complete your MongoDB assignment.
