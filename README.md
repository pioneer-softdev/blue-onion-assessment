# Blue Onion Labs Take Home Assignment

## **Overview**
This project is a full-stack web application built using Ruby on Rails** for the backend and React (TypeScript) for the frontend. The application processes order and payment data from a provided CSV file and generates monthly aggregated journal entries following double-entry accounting principles.

The application runs inside Docker containers, making it easy to set up and deploy.

---

## **Running the Application (via Docker)**

### **Prerequisites**
Ensure you have Docker and Docker Compose installed:
- **Docker**: [Download Here](https://www.docker.com/get-started)
- **Docker Compose** (Comes bundled with Docker Desktop)

### **Clone the Repository**
```sh
git clone https://github.com/pioneer-softdev/blue-onion-assessment.git
cd interview-fullstack
```

### **Run the Application**
```sh
docker-compose up --build
```

This command:
- Builds the backend (Rails API) and frontend (React)
- Starts a PostgreSQL database container
- Runs database migrations
- Imports data.csv into the database
- Launches the application

### **Access the Application**
- **Backend API:** [http://localhost:3000](http://localhost:3000)
- **Frontend Web App:** [http://localhost:5173](http://localhost:5173)

### **Manually Re-import CSV Data** (Optional)
If needed, you can manually re-import `data.csv`:
```sh
docker-compose exec backend rails import:orders_and_payments
```

### **Stopping the Application**
```sh
docker-compose down
```

---

## **Running Backend Tests**
This project includes RSpec tests for:
- Models (`Order`, `Payment`) to ensure correct calculations.
- Service Layer (`JournalEntryService`) to verify accurate data aggregation.
- API Endpoints (`/api/journal_entries`, `/api/journal_entries/months`).

### **Run All Tests**
```sh
docker-compose exec backend rspec
```

### **Run Specific Test File**
```sh
docker-compose exec backend rspec spec/services/journal_entry_service_spec.rb
```

---

## **Thought Process & Decisions**

### **Backend Design (Rails API)**
- Used Ruby on Rails for quick development and strong support for Active Record ORM.
- Designed database tables for `orders`, `payments`, and `journal_entries`.
- Implemented a Rake task (`import:orders_and_payments`) to read `data.csv` and populate the database.
- Ensured CORS support to allow API calls from the frontend.
- Used Docker to make setup easier and prevent dependency issues.

### **Data Aggregation & Journal Entries**
- **Monthly Aggregation:**
  - Orders are grouped by month (`ordered_at` date).
  - Payments are summed for each order within the same month.

- **Assumptions in Aggregation:**
  - If an order has multiple payments, they are summed together.
  - Payments are applied to the same month as the order.
  - All transactions balance (`total debits = total credits`).

### **Frontend (React + TypeScript)**
- Built a simple UI using React + TypeScript.
- Implemented a month selector dropdown to allow users to select a month.
- Displayed journal entries in a table format, ensuring clarity and correctness.
- Used Tailwind CSS for modern styling.
- Created a custom hook (`useJournalEntries`) for managing API calls and state.

### **Deployment & Dockerization**
- Dockerized backend, frontend, and database to ensure seamless setup.
- Used Docker Compose to manage multi-container environments.
- Mounted `data.csv` inside the backend container to enable CSV import.
- Automated database migrations and CSV import upon backend startup.

---

## **Future Improvements**
- **Implement Authentication** (e.g., API keys, JWT) to secure API endpoints.
- **Optimize Docker Images** to reduce build size and speed up deployment.
- **Deploy to Cloud** (e.g., AWS, DigitalOcean, Vercel) for production-ready hosting.
- **Add Logging & Monitoring** to track API performance and errors.
- **Enhance UI with Charts** to visualize financial data better.

---

## **Conclusion**
This project successfully processes orders and payments, aggregates them into monthly journal entries, and displays them in a structured format. The Docker-based setup ensures easy deployment, and the React + Rails architecture provides a scalable foundation for future enhancements.

Thank you for reviewing this assessment! 🚀

