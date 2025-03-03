import { useEffect, useState } from "react";
import { fetchJournalEntries, fetchAvailableMonths } from "../api/journal";
import { JournalEntriesResponse } from "../types";

const useJournalEntries = () => {
  const [selectedMonth, setSelectedMonth] = useState<string>("");
  const [journalData, setJournalData] = useState<JournalEntriesResponse | null>(null);
  const [months, setMonths] = useState<string[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Fetch available months when component mounts
  useEffect(() => {
    fetchAvailableMonths()
      .then(setMonths)
      .catch(() => setError("Failed to load months"));
  }, []);

  // Fetch journal entries when selected month changes
  useEffect(() => {
    if (!selectedMonth) return;
    setLoading(true);
    fetchJournalEntries(selectedMonth)
      .then((data: JournalEntriesResponse) => setJournalData(data))
      .catch(() => setError("Failed to load journal entries"))
      .finally(() => setLoading(false));
  }, [selectedMonth]);

  return { selectedMonth, setSelectedMonth, journalData, months, loading, error };
};

export default useJournalEntries;
