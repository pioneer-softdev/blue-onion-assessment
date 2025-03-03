import React from "react";
import { JournalEntry } from "../types";

interface Props {
  journalEntries: JournalEntry[];
  total: { debit: number; credit: number };
}

const JournalTable: React.FC<Props> = ({ journalEntries, total }) => {
  return (
    <div className="overflow-x-auto">
      <table className="min-w-full bg-white shadow-md rounded-lg">
        <thead className="bg-gray-200">
          <tr>
            <th className="px-4 py-2 text-left">Account</th>
            <th className="px-4 py-2 text-right">Debit</th>
            <th className="px-4 py-2 text-right">Credit</th>
            <th className="px-4 py-2 text-right">Description</th>
          </tr>
        </thead>
        <tbody>
          {journalEntries.map((entry, index) => (
            <tr key={index} className="border-b">
              <td className="px-4 py-2">{entry.account}</td>
              <td className="px-4 py-2 text-right">{entry.debit > 0 ? `$${entry.debit.toFixed(2)}` : "-"}</td>
              <td className="px-4 py-2 text-right">{entry.credit > 0 ? `$${entry.credit.toFixed(2)}` : "-"}</td>
              <td className="px-4 py-2 text-right">{entry.description}</td>
            </tr>
          ))}
          <tr className="font-bold bg-gray-100">
            <td className="px-4 py-2">Total</td>
            <td className="px-4 py-2 text-right">${total.debit.toFixed(2)}</td>
            <td className="px-4 py-2 text-right">${total.credit.toFixed(2)}</td>
            <td className="px-4 py-2 text-right"></td>
          </tr>
        </tbody>
      </table>
    </div>
  );
};

export default JournalTable;
