require_dependency 'journal_entry_service'

class Api::JournalEntriesController < ApplicationController
  def index
    month = params[:month]

    unless month.present?
      return render json: { error: "Missing month parameter" }, status: :bad_request
    end

    journal_entries = JournalEntryService.generate_monthly_journal_entries(month)

    render json: journal_entries
  end

  def months
    months = JournalEntryService.get_available_months
    render json: { months: }
  end
end
