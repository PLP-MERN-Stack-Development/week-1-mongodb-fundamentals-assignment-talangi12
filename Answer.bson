
Task 1: MongoDB Setup
Installation (done):
 
Database and Collection Creation:
The insert_books.js script will automatically create the plp_bookstore database and the books collection if they don't exist. If the books collection already exists and has documents, the script will drop it and re-insert the data.
Task 2: Basic CRUD Operations
Populate Data:
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
db.books.find({ author: "George Orwell", published_year: 1949 }).explain("executionStats"


## Submission Files

The following files are included in this repository for submission:

* `insert_books.js`: The script used to populate the MongoDB database with sample book data.
* `queries.js`: Contains all the MongoDB queries for basic CRUD operations, advanced queries, aggregation pipelines, and indexing.
* `README.md`: This file, explaining the setup and how to run the scripts.
* `screenshot.png`: A screenshot showing the MongoDB Compass or Atlas interface with the `plp_bookstore` database and `books` collection and some sample data.


