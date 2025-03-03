import React from "react";
import useJournalEntries from "../hooks/useJournalEntries";
import JournalTable from "../components/JournalTable";
import MonthSelector from "../components/MonthSelector";

const Home: React.FC = () => {
  const { selectedMonth, setSelectedMonth, journalData, months, loading, error } = useJournalEntries();

  return (
    <div className="max-w-4xl mx-auto mt-10 p-6 bg-gray-100 shadow-md rounded-lg">
      <h1 className="text-2xl font-bold mb-4">Monthly Journal Entries</h1>
      <MonthSelector selectedMonth={selectedMonth} onMonthChange={setSelectedMonth} months={months} />

      {loading && <p className="text-blue-500">Loading...</p>}
      {error && <p className="text-red-500">{error}</p>}
      {journalData && <JournalTable journalEntries={journalData.journal_entries} total={journalData.total} />}
    </div>
  );
};

export default Home;
