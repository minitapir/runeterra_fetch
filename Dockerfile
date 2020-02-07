FROM ruby:latest

WORKDIR /app/
COPY Gemfile* ./
RUN bundle

COPY ./ /app/

CMD ["ruby", "app.rb"]