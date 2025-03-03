# Use official Ruby image
FROM ruby:3.4.1

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn

# Set working directory
WORKDIR /app

# Copy the Gemfile and install dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the rest of the app
COPY . .

# Expose port 3000 for Rails server
EXPOSE 3000

# Start the Rails server
CMD ["sh", "-c", "rails db:migrate && rails import:orders_and_payments && rails server -b 0.0.0.0"]
