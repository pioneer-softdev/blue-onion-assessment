import axios from "axios";
import { JournalEntriesResponse } from "../types";

const API_BASE_URL = "http://localhost:3000/api";

export const fetchJournalEntries = async (month: string): Promise<JournalEntriesResponse> => {
  const response = await axios.get(`${API_BASE_URL}/journal_entries`, {
    params: { month },
  });
  return response.data;
};

export const fetchAvailableMonths = async (): Promise<string[]> => {
  const response = await axios.get(`${API_BASE_URL}/journal_entries/months`);
  return response.data.months;
};
