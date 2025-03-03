import React from "react";

interface Props {
  selectedMonth: string;
  onMonthChange: (month: string) => void;
  months: string[];
}

const MonthSelector: React.FC<Props> = ({ selectedMonth, onMonthChange, months }) => {
  return (
    <div className="mb-4">
      <label className="text-lg font-semibold">Select Month:</label>
      <select
        className="p-2 border border-gray-300 rounded-lg ml-2"
        value={selectedMonth}
        onChange={(e) => onMonthChange(e.target.value)}
      >
        <option value="">-- Choose Month --</option>
        {months.map((month) => (
          <option key={month} value={month}>{month}</option>
        ))}
      </select>
    </div>
  );
};

export default MonthSelector;
