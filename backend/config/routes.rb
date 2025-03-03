Rails.application.routes.draw do
  namespace :api do
    get "journal_entries", to: "journal_entries#index"
    get "journal_entries/months", to: "journal_entries#months"
  end
end
