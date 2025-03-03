export interface JournalEntry {
  account: string;
  debit: number;
  credit: number;
  description: string;
}

export interface JournalEntriesResponse {
  month: string;
  journal_entries: JournalEntry[];
  total: {
    debit: number;
    credit: number;
  };
}
